#!/usr/bin/env bash
# Downloads one font set from TJ-CSCCG/cjk-fonts-for-ctex's latest release into
# the project's fonts/ folder, where the class loads it (see the fontdir option).
# Used by `make fonts` and CI; Windows has the same in make.bat.
#
# Usage: scripts/fetch-fonts.sh [windows|founder|adobe|fandol] [DIR]
#        (defaults: windows, fonts)

set -euo pipefail

set_name=${1:-windows}
dir=${2:-fonts}
case $set_name in
  windows|founder|adobe|fandol) ;;
  *) echo "Unknown font set: $set_name (expected windows, founder, adobe or fandol)" >&2; exit 2 ;;
esac

url="https://github.com/TJ-CSCCG/cjk-fonts-for-ctex/releases/latest/download/${set_name}.zip"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

echo "Downloading the ${set_name} font set into ${dir}/ ..."
curl -fsSL --retry 3 -o "$tmp/fonts.zip" "$url"
mkdir -p "$dir"
unzip -o -q "$tmp/fonts.zip" -d "$dir"
ls "$dir"
