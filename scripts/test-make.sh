#!/usr/bin/env bash
# Tests the build entry points themselves: the Makefile, or make.bat on Windows.
# The compile jobs in test.yaml only take the success path with every tool
# installed; this script checks what a writer meets before that:
#
#   no-tex    No TeX on PATH. `help` works, and each target names the one
#             tool it is missing.
#   texcount  TeXcount on PATH, latexmk still absent. Build targets still
#             refuse, and `wordcount` prints the counts TeXcount itself gives,
#             for the multi-file thesis and for one-file documents.
#
# Usage: bash scripts/test-make.sh no-tex|texcount

set -uo pipefail

stage=${1:-}
case $stage in
  no-tex|texcount) ;;
  *) echo "Usage: bash scripts/test-make.sh no-tex|texcount" >&2; exit 2 ;;
esac

root=$(cd "$(dirname "$0")/.." && pwd)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
failures=0

is_windows() { [[ ${RUNNER_OS:-} == Windows || $OSTYPE == msys* || $OSTYPE == cygwin* ]]; }

# run_make DIR TARGET: run the platform's entry point in DIR.
# Sets $out (stdout and stderr together) and $status.
run_make() {
  local dir=$1 target=$2
  if is_windows; then
    out=$(cd "$dir" && MSYS_NO_PATHCONV=1 cmd /d /c "call make.bat $target" </dev/null 2>&1)
  else
    out=$(make -C "$dir" --no-print-directory "$target" </dev/null 2>&1)
  fi
  status=$?
}

pass() { echo "ok   - $1"; }
fail() {
  echo "FAIL - $1"
  printf '%s\n' "$out" | sed 's/^/       | /'
  failures=$((failures + 1))
}

# expect_ok NAME PATTERN: the last run exited 0 and printed PATTERN.
expect_ok() {
  if ((status == 0)) && grep -q -- "$2" <<<"$out"; then pass "$1"
  else fail "$1 (exit $status; expected 0 and output matching '$2')"; fi
}

# expect_error NAME PATTERN: the last run failed and printed PATTERN.
expect_error() {
  if ((status != 0)) && grep -q -- "$2" <<<"$out"; then pass "$1"
  else fail "$1 (exit $status; expected non-zero and output matching '$2')"; fi
}

# count_of LABEL: the number the last run printed after LABEL. The labels'
# English part is matched, so the Makefile's "(Chinese characters)\t:" and
# make.bat's "Chinese characters:" both read.
count_of() {
  sed -n "s/.*$1[^0-9]*\([0-9][0-9]*\).*/\1/p" <<<"$out" | head -n 1
}

# expect_count NAME LABEL EXPECTED
expect_count() {
  local got
  got=$(count_of "$2")
  if ((status == 0)) && [[ $got == "$3" ]]; then pass "$1: $2 = $3"
  else fail "$1: $2 expected $3, got '${got:-nothing}' (exit $status)"; fi
}

# texcount_says DIR MODE: words in text by TeXcount's own one-line summary
# (-1), a different output path from the detailed block the entry points read.
texcount_says() {
  (cd "$1" && texcount main.tex -inc -1 "$2" 2>/dev/null) |
    sed -n 's/^\([0-9][0-9]*\)+.*/\1/p' | head -n 1
}

# fixture NAME BODY: a directory holding the entry points and a one-file main.tex.
fixture() {
  local dir="$work/$1"
  mkdir -p "$dir"
  cp "$root/Makefile" "$root/make.bat" "$dir/"
  printf '%s\n' "$2" >"$dir/main.tex"
  echo "$dir"
}

if [[ $stage == no-tex ]]; then
  for tool in latexmk texcount; do
    if command -v "$tool" >/dev/null 2>&1; then
      echo "Precondition: $tool is on PATH. Run the no-tex stage before TeX Live is installed." >&2
      exit 2
    fi
  done

  run_make "$root" help
  expect_ok "help runs without TeX" "Available targets"
  for target in all forms clean; do
    run_make "$root" "$target"
    expect_error "$target names the missing latexmk" "latexmk not found in PATH"
  done
  run_make "$root" wordcount
  expect_error "wordcount names the missing texcount" "texcount not found in PATH"
else
  if ! command -v texcount >/dev/null 2>&1; then
    echo "Precondition: texcount is not on PATH. Install it before the texcount stage." >&2
    exit 2
  fi
  if command -v latexmk >/dev/null 2>&1; then
    echo "Precondition: latexmk is on PATH. This stage checks that build targets refuse without it; install TeXcount alone." >&2
    exit 2
  fi

  run_make "$root" all
  expect_error "all still names the missing latexmk when only texcount is installed" "latexmk not found in PATH"

  # The template's own thesis: several files pulled in by \input.
  chinese=$(texcount_says "$root" -ch-only)
  total=$(texcount_says "$root" -chinese)
  run_make "$root" wordcount
  if [[ -n $chinese && $chinese -gt 0 ]]; then
    expect_count "thesis" "Chinese characters" "$chinese"
    expect_count "thesis" "Total characters" "$total"
  else
    fail "TeXcount reports no Chinese characters in the thesis ('${chinese:-nothing}')"
  fi

  # One-file documents print no per-file sums, which is where a count used to go missing.
  dir=$(fixture chinese '\documentclass{article}
\begin{document}
你好世界
\end{document}')
  run_make "$dir" wordcount
  expect_count "one-file Chinese" "Chinese characters" 4
  expect_count "one-file Chinese" "Total characters" 4

  dir=$(fixture english '\documentclass[english]{article}
\begin{document}
Hello world
\end{document}')
  run_make "$dir" wordcount
  expect_count "one-file English" "Latin characters" 10
  expect_count "one-file English" "Total characters" 2

  dir=$(fixture empty '\documentclass{article}
\begin{document}
\end{document}')
  run_make "$dir" wordcount
  expect_count "one-file empty body" "Chinese characters" 0
  expect_count "one-file empty body" "Total characters" 0
fi

if ((failures > 0)); then
  echo "$failures check(s) failed." >&2
  exit 1
fi
echo "All $stage checks passed."
