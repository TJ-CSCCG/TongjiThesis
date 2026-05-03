#!/bin/bash
# Bump version across all files and optionally create a git tag.
#
# Usage:
#   ./scripts/bump-version.sh <new-version> [--tag]
#
# Examples:
#   ./scripts/bump-version.sh 1.4.0
#   ./scripts/bump-version.sh 1.4.0 --tag
#
# Updates:
#   - package.json              "version" field
#   - style/tongjithesis.cls    \ProvidesClass date and version
#   - style/tongjithesis.cfg    \ProvidesFile  date and version
#   - style/font/*.def          \ProvidesFile  date and version

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <new-version> [--tag]"
  echo "Example: $0 1.4.0 --tag"
  exit 1
fi

NEW_VERSION="$1"
CREATE_TAG=false
if [ "${2:-}" = "--tag" ]; then
  CREATE_TAG=true
fi

# Validate semver format
if ! echo "$NEW_VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "Error: version must be in X.Y.Z format (got '$NEW_VERSION')"
  exit 1
fi

OLD_VERSION=$(jq -r '.version' package.json)
TODAY=$(date +%Y/%m/%d)

if [ "$OLD_VERSION" = "$NEW_VERSION" ]; then
  echo "Error: new version ($NEW_VERSION) is the same as current version"
  exit 1
fi

echo "Bumping $OLD_VERSION → $NEW_VERSION (date: $TODAY)"

# package.json
sed -i.bak "s/\"version\": \"${OLD_VERSION}\"/\"version\": \"${NEW_VERSION}\"/" package.json
rm package.json.bak

# tongjithesis.cls — update date and version in \ProvidesClass line
sed -i.bak -E 's#(\\ProvidesClass\{tongjithesis\}\[)[0-9][0-9/]* v[0-9]+\.[0-9]+\.[0-9]+#\1'"${TODAY} v${NEW_VERSION}#" style/tongjithesis.cls
rm style/tongjithesis.cls.bak

# tongjithesis.cfg — update date and version in \ProvidesFile line
sed -i.bak -E 's#(\\ProvidesFile\{tongjithesis\.cfg\}\[)[0-9][0-9/]* v[0-9]+\.[0-9]+\.[0-9]+#\1'"${TODAY} v${NEW_VERSION}#" style/tongjithesis.cfg
rm style/tongjithesis.cfg.bak

# style/font/*.def — update date and version in \ProvidesFile lines
for def in style/font/tongji-cjk-font-*.def; do
  sed -i.bak -E 's#(\\ProvidesFile\{[^}]+\}\[)[0-9][0-9/]* v[0-9]+\.[0-9]+\.[0-9]+#\1'"${TODAY} v${NEW_VERSION}#" "$def"
  rm "${def}.bak"
done

echo ""
echo "Updated files:"
grep -n "version\|Provides" package.json style/tongjithesis.cls style/tongjithesis.cfg \
  | grep -E "version|Provides(Class|File)"

echo ""
git diff --stat

git add package.json style/tongjithesis.cls style/tongjithesis.cfg style/font/*.def
git commit -m "chore: bump version to v${NEW_VERSION}"

if [ "$CREATE_TAG" = true ]; then
  git tag "v${NEW_VERSION}"
  echo ""
  echo "Tagged v${NEW_VERSION}. Push with:"
  echo "  git push && git push origin v${NEW_VERSION}"
else
  echo ""
  echo "Done. To also create a tag, run:"
  echo "  git tag v${NEW_VERSION}"
  echo "  git push && git push origin v${NEW_VERSION}"
fi
