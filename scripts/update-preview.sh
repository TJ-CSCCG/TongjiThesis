#!/bin/bash
# Generate preview images from a compiled PDF and push to TJCS-Images repo.
#
# Usage:
#   ./scripts/update-preview.sh [path-to-pdf] [--amend]
#
# Options:
#   --amend    Amend the previous commit and force-push (useful for updates)
#
# If no PDF is specified, uses main.pdf in the current directory.
# Requires: python3, pdf2image (pip install pdf2image), poppler, git

set -euo pipefail

# Parse arguments
AMEND=false
PDF="main.pdf"
for arg in "$@"; do
  case "$arg" in
    --amend) AMEND=true ;;
    *) PDF="$arg" ;;
  esac
done

DPI=300
QUALITY=95
REPO_URL="https://github.com/TJ-CSCCG/TJCS-Images.git"
BRANCH="TongjiThesis"
COMPAT_BRANCH="tongji-undergrad-thesis"  # backward-compat alias
TMPDIR=$(mktemp -d)

if [ ! -f "$PDF" ]; then
  echo "Error: PDF file '$PDF' not found."
  echo "Usage: $0 [path-to-pdf]"
  exit 1
fi

echo "=== Generating preview images from $PDF ==="

# Convert PDF pages to JPG
python3 -c "
from pdf2image import convert_from_path
import os, sys

pdf = sys.argv[1]
outdir = sys.argv[2]
dpi = int(sys.argv[3])
quality = int(sys.argv[4])

imgs = convert_from_path(pdf, dpi=dpi)
print(f'Total pages: {len(imgs)}')
for i, img in enumerate(imgs):
    path = os.path.join(outdir, f'main_page-{i+1:04d}.jpg')
    img.save(path, 'JPEG', quality=quality)
print(f'Saved {len(imgs)} images to {outdir}')
" "$PDF" "$TMPDIR" "$DPI" "$QUALITY"

echo ""
echo "=== Pushing to $REPO_URL ($BRANCH) ==="

# Clone the images repo
CLONE_DIR=$(mktemp -d)
git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "$CLONE_DIR" 2>&1 | tail -3

# Replace preview images
rm -f "$CLONE_DIR/preview/main_page-"*.jpg
cp "$TMPDIR/main_page-"*.jpg "$CLONE_DIR/preview/"

cd "$CLONE_DIR"
git add preview/
CHANGED=$(git diff --cached --stat | tail -1)
if [ -z "$CHANGED" ]; then
  echo "No changes — preview images are already up to date."
  exit 0
fi

PAGE_COUNT=$(ls preview/main_page-*.jpg | wc -l | tr -d ' ')
if [ "$AMEND" = true ]; then
  git commit --amend --no-edit
  git push --force-with-lease origin "$BRANCH"
else
  git commit -m "update preview images ($PAGE_COUNT pages, ${DPI}dpi)"
  git push origin "$BRANCH"
fi

# Update backward-compat branch to point to the same commit
echo ""
echo "=== Syncing $COMPAT_BRANCH branch ==="
git push origin "$BRANCH:$COMPAT_BRANCH" --force-with-lease 2>/dev/null \
  && echo "Synced $COMPAT_BRANCH → $BRANCH" \
  || echo "Warning: could not sync $COMPAT_BRANCH (may not exist)"

echo ""
echo "=== Done ==="
echo "Pushed $PAGE_COUNT preview images to $REPO_URL ($BRANCH)"

# Cleanup
rm -rf "$TMPDIR" "$CLONE_DIR"
