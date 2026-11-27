#!/usr/bin/env bash
# Decides whether ci.yml may skip its build jobs for the commit under test.
# They skip when the commit differs from a tree an earlier test run already
# passed on only in what a release-please release commit writes: CHANGELOG.md,
# .release-please-manifest.json, the "version" line of package.json, and the
# lines marked x-release-please-version in the extra-files listed in
# release-please-config.json. The same tree (no difference at all) also skips.
# Anything the script cannot read means every job runs.
#
# Needs a full-history checkout and GH_TOKEN (actions: read), GITHUB_REPOSITORY
# and GITHUB_OUTPUT. Writes skip=true|false, and proven_by=<run URL> when true.

set -uo pipefail

out() { echo "$1=$2" >>"$GITHUB_OUTPUT"; }
run_everything() {
  echo "Running every job: $1."
  out skip false
  exit 0
}

[[ -f release-please-config.json ]] || run_everything "release-please-config.json is missing"

# Trees that passed: the head commits of successful runs that tested their own
# head commit (push, release, manual run). A pull_request run tests a merge
# commit whose tree its head_sha does not carry, so those runs are left out.
runs=$(gh api "repos/$GITHUB_REPOSITORY/actions/workflows/ci.yml/runs?status=success&per_page=100" \
  --jq '.workflow_runs[] | select(.event != "pull_request") | "\(.head_sha) \(.html_url)"') ||
  run_everything "the list of passed runs could not be read"

# One "<tree> <run URL>" line per passed run whose commit is in this clone.
proven=$(while read -r sha url; do
  [[ -n $sha ]] || continue
  tree=$(git rev-parse -q --verify "${sha}^{tree}" 2>/dev/null) || continue
  echo "$tree $url"
done <<<"$runs")

# The nearest first-parent ancestor of HEAD, HEAD included, whose tree passed.
base=""
by=""
for commit in $(git rev-list --first-parent --max-count=50 HEAD); do
  tree=$(git rev-parse "${commit}^{tree}")
  url=$(grep -m1 "^$tree " <<<"$proven" | cut -d' ' -f2)
  if [[ -n $url ]]; then
    base=$commit
    by=$url
    break
  fi
done
[[ -n $base ]] || run_everything "no tree among the last 50 commits has passed"

version_files=$(jq -r '.packages["."]["extra-files"][] | if type == "string" then . else .path end' release-please-config.json) ||
  run_everything "release-please-config.json could not be read"

while IFS= read -r file; do
  case $file in
    CHANGELOG.md | .release-please-manifest.json) continue ;;
    package.json) marker='"version":' ;;
    *)
      if grep -qxF -- "$file" <<<"$version_files"; then
        marker='x-release-please-version'
      else
        run_everything "$file changed since the tree that passed in $by"
      fi
      ;;
  esac
  # Every added or removed line of the file must be a version line. The lines
  # are collected first, so an early-exiting grep cannot make an upstream
  # command's SIGPIPE decide the result under pipefail.
  changed=$(git diff -U0 "$base" HEAD -- "$file" | grep -E '^[+-]' | grep -vE '^(\+\+\+|---) ' || true)
  if [[ -n $changed ]] && grep -vqF -- "$marker" <<<"$changed"; then
    run_everything "$file changed beyond its version line since the tree that passed in $by"
  fi
done < <(git diff --name-only "$base" HEAD)

echo "Skipping the build jobs: since the tree that passed in $by, only release-please's version lines changed."
out skip true
out proven_by "$by"
