# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Guidance for this repo is consolidated in `AGENTS.md` (single source of truth). The import below pulls it in for Claude Code.

@AGENTS.md

## Working-tree clutter

- The repo root may accumulate untracked LaTeX build byproducts beyond the usual gitignored set — stray aux/log/pdf files from one-off local test documents, or BibTeX-generated control files — left over from ad hoc local compiles. Leave them alone unless asked to clean up; they are not part of the tracked project.
- Untracked Word documents at the repo root, if present, are local reference copies of Tongji University's official spec, kept for compliance cross-checking against `style/tongjithesis.cls`. They are not part of the repository and should not be committed.
