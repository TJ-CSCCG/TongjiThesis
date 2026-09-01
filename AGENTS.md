# AGENTS.md

Single source of truth for agent and human contributor guidance in this repository. Tool-specific config files (e.g. `CLAUDE.md`) import this file rather than duplicate it. `README.md`/`README-EN.md` and `CONTRIBUTING.md` cover the end-user and human-contributor view; this file is the denser, agent-facing counterpart — prefer it when deciding *how* to change something, not just *what* it does.

## What this repository is

`tongjithesis` is a LaTeX document class implementing Tongji University's official undergraduate thesis (本科毕业设计/论文) formatting requirements, distributed as a template via GitHub, Overleaf, and CTAN. Its consumers are two distinct audiences with opposite editing surfaces:

- **Thesis writers** clone/fork the repo, edit only `chapters/metadata.tex` (front-matter fields) and their own chapter content, and never touch `style/`.
- **Class maintainers** (this repo's contributors) edit `style/tongjithesis.cls` and friends to track Tongji's periodically revised official spec, without breaking any writer's existing document.

Every change should be evaluated against which audience it affects, and whether it could silently break a thesis someone has already started writing against a pinned version.

## Repository layout

| Path | Role |
| --- | --- |
| `style/tongjithesis.cls` | The class itself — options, layout, bibliography backends, cover/abstract macros, task book/proposal/mid-term report macros. Organized into `% ====` banner-delimited sections (see § Architecture). |
| `style/tongjithesis.cfg` | Loaded last by the class; the intended fork point for local overrides that shouldn't live in `.cls`. |
| `style/tongji-circled.def` | Circled-numeral (①②…) glyph support for footnote markers, level-2 list labels, and `\paragraph` numbering. |
| `style/font/*.def` | Per-fontset CJK font mappings (`fandol`/`mac`/`windows`/`adobe`/`founder`), selected by the `fontset` class option. |
| `chapters/metadata.tex` | The one file thesis writers are meant to edit for front matter — school, author, title, advisor, info-page fields, plus `\taskbookperiod{...}` (task book start/end dates; only consumed when compiling `taskbook.tex`, harmless otherwise). |
| `chapters/01_guide.tex` | "模板使用指南" — the compiled usage manual (class options, structure, command cheat-sheet). This *is* the user documentation; it ships inside every compiled PDF. |
| `chapters/02_intro.tex`…`06_conclusion.tex` | Demo body chapters, one topic each: headings/lists/fonts, floats (figures/tables/algorithms/code), math/units/theorems, citations/footnotes/cross-references, conclusion structure — see `01_guide.tex`'s own per-chapter summary. |
| `chapters/00_abstract.tex`, `ack.tex`, `appendix.tex` | Abstract, acknowledgements, appendix demos. |
| `chapters/taskbook_body.tex`, `proposal_body.tex`, `midterm_body.tex` | Body content `\input` by `taskbook.tex`/`proposal.tex`/`midterm.tex` respectively — the administrative-document analogue of `chapters/02_intro.tex`…`06_conclusion.tex` for the thesis body. |
| `bib/note.bib` | Example bibliography database, including GB/T 7714-2025 entry types (e.g. `@preprint`). |
| `figures/` | Cover/header logo assets and other example figures. |
| `main.tex` | Compilation entry point and example thesis skeleton for the thesis body (`doctype=thesis`, the default) — the `\documentclass[...]` option block here is also what CI mutates to test option combinations (see § Behavioral rules). One of 4 top-level compilation entry points; see the next row for the other 3. |
| `taskbook.tex` / `proposal.tex` / `midterm.tex` | Standalone compilation entry points for the 3 official administrative documents (毕业设计任务书/开题报告/中期报告), each setting `doctype=taskbook\|proposal\|midterm` respectively. They share `chapters/metadata.tex` with `main.tex` but are otherwise independent — no `\MakeCover`/`\MakeInfoPage`/frontmatter/mainmatter/bibliography, just `\input{chapters/metadata}` → `\MakeDocument` → `\input{chapters/{taskbook,proposal,midterm}_body}`. |
| `Makefile` / `make.bat` | Build entry points for Unix/macOS and Windows respectively. Keep target names and behavior in sync between the two. |
| `latexmkrc` | latexmk engine (`$pdf_mode=5`, XeLaTeX+xdvipdfmx), search paths, and clean-file list. |
| `scripts/build-ctan.sh` | Single source of truth for the CTAN distribution: assembles `ctan/tongjithesis/` (class + `.cfg` + every `.def` + generated LICENSE/README/MANIFEST/example) and validates the file list. Shared by `release.yml` (which archives the result) and `test.yaml`'s `build-ctan` job (which compiles the packaged example). Add a file the class needs at runtime here, or the shipped package silently breaks. |
| `scripts/update-preview.sh` | Renders the compiled PDF to page images and pushes them to the sibling `TJ-CSCCG/TJCS-Images` repo (used by the Overleaf template gallery). |
| `release-please-config.json` / `.release-please-manifest.json` | `release-please` config — `release-type: node` (version source of truth is `package.json`), plus an `extra-files` list of the `\Provides*`-bearing files it keeps in sync. See § Branching and versioning. |
| `.github/workflows/test.yaml` | The CI build matrix — functions as this project's test suite (see § Behavioral rules). |
| `.github/workflows/release-please.yml` | Runs on push to `master`; maintains a release PR (version bump + `CHANGELOG.md`) and, on merge, creates the tag and a draft GitHub Release. Uses a GitHub App token so the release it creates can trigger other workflows. |
| `.github/workflows/release.yml` | Runs on the release-please draft being published: builds the CTAN package (via `scripts/build-ctan.sh`) and source archives, attaches them to that release, and moves the floating `vX.Y` tag. Does not create the release itself. |

## Branching and versioning

- Feature and fix branches are cut from `dev` and PR back into `dev` — **not** `master`, even though `master` is GitHub's default branch (so the base branch must be set explicitly when opening a PR). `dev` is periodically fast-forwarded into `master` for a release; `master` is always an ancestor of `dev`, never diverges from it. This holds for automation too: `.github/dependabot.yml` sets `target-branch: dev` so dependency PRs follow the same path.
- **A release is the one thing that commits directly to `master`, so it needs a back-sync.** `release-please` merges the version bumps and `CHANGELOG.md` into `master` alone, which momentarily leaves `master` one commit *ahead* of `dev` and breaks the invariant above — the next `git merge --ff-only dev` would fail. Immediately after the release PR merges, fast-forward the other way to restore it:

  ```sh
  git checkout dev && git merge --ff-only origin/master && git push origin dev
  ```

  Do this before letting anything else land on `dev`; once `dev` has moved on, the two branches have genuinely diverged and only a merge commit can reconcile them.
- Commits observably follow Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`, `ci:`, …), though this is not yet CI-enforced on `dev`.
- **Never hand-edit the version string on `dev` or a feature branch.** `release-please` owns `\ProvidesClass`/`\ProvidesFile` lines across `style/*.cls|*.cfg|*.def` and `package.json`'s `version` field (its `extra-files` list in `release-please-config.json`), driven by Conventional Commits on `master`: it maintains a standing release PR, and merging that PR bumps every version line and regenerates `CHANGELOG.md` in one commit. There is no local bump command — don't write one, and don't edit a `\Provides*` line by hand outside that flow. Changelog-worthy context can still go into `CONTRIBUTING.md`'s project-history table in a regular PR.

## Commands

| Task | Command | Notes |
| --- | --- | --- |
| Build (XeLaTeX, default) | `make` | alias for `make all` |
| Build with LuaLaTeX | `make ENGINE=-lualatex all` | `ENGINE` must be `-xelatex` or `-lualatex`; pdfLaTeX is unsupported (CJK + font requirements) |
| Continuous preview | `make pvc` | `latexmk -pvc`, recompiles on save |
| Open compiled PDF | `make view` | |
| Character count (CN/EN) | `make wordcount` | via `texcount`; branches on whether `main.tex` sets an `english` class option — not a `tongjithesis`-documented option, just a literal string match in the Makefile |
| Remove aux files | `make clean` | |
| Remove aux files + PDF | `make cleanall` | |
| Windows equivalents | `.\make.bat thesis [-xelatex\|-lualatex]`, `.\make.bat wordcount`, `.\make.bat clean` / `cleanall` | engine is a positional arg, not an env-style token — see `.\make.bat help` |
| Build the 3 standalone admin documents | `make taskbook` / `make proposal` / `make midterm` (one at a time) or `make forms` (all 3) | Windows: `.\make.bat taskbook\|proposal\|midterm\|forms`; mirrors `test.yaml`'s `build-forms` job |
| Exercise one CI matrix leg locally | edit the matching option in `main.tex`'s `\documentclass[...]` block (`biblatex=false`, `field=humanities`, `minted=true`, `algo=algorithm2e`, `twoside`), then `make` | mirrors `test.yaml`'s `build-variants` job |
| Build + validate the CTAN package | `scripts/build-ctan.sh` | writes `ctan/` (gitignored); mirrors `test.yaml`'s `build-ctan` job, which then compiles `ctan/tongjithesis/example/example.tex` |
| Regenerate README preview images | `./scripts/update-preview.sh [path-to-pdf] [--amend]` | pushes to `TJ-CSCCG/TJCS-Images` |

Releases are not a local command: merge `release-please`'s standing release PR on `master`, then publish the draft GitHub Release it creates — that publish event triggers `release.yml` to attach the CTAN/PDF assets.

`latexmk` and `texcount` must be on `PATH` — the Makefile hard-errors at parse time otherwise (`$(foreach REQUIRED_PROGRAMS...)`).

## Behavioral rules

**A class feature isn't done until it's demonstrated in `chapters/`.** `01_guide.tex` is the compiled user manual; README/CONTRIBUTING link to it rather than restate it. A new `\documentclass` option or user-facing macro needs a working example there, and ideally a new leg in `test.yaml`'s `build-variants` matrix.

**`field=science` and `field=humanities` are two independent code paths, not one parametrized path.** Chapter/section numbering, TOC formatting, and heading style branch on `\iftongjithesis@humanities` in several places in `tongjithesis.cls`. A numbering or heading fix usually needs the mirrored change in both branches — check both before calling a typography fix complete.

**The two bibliography backends must stay behaviorally identical.** `biblatex=true` (biblatex+biber, `style=gb7714-2025`) and `biblatex=false` (bibtex+`gbt7714`, `bibliographystyle{gbt7714-2025-numeric}`) both implement GB/T 7714-2025 punctuation (`gbpunctwidth=mixed` / `bibpunct=GB`) and the same 0.74cm hanging-indent label geometry. A label-alignment or punctuation fix in one backend almost always needs the mirrored fix in the other — see the § Bibliography Configuration comments in `tongjithesis.cls` for the current implementation, including the `\AtBeginDocument{\let\@bibsetup\tj@bibsetup}` hook-ordering fix required because `gbt7714`'s bundled `natbib` overrides `thebibliography` itself and bypasses `book.cls`'s `\@openbib@code` hook.

**CI is the test suite; there is no separate unit-test framework.** `test.yaml`'s `build` job (3 OS × {XeLaTeX, LuaLaTeX}, default options), `build-variants` job (option combinations applied to `main.tex` via `sed`), `build-forms` job (compiles `taskbook.tex`/`proposal.tex`/`midterm.tex`, one matrix leg per document), and `build-ctan` job (runs `scripts/build-ctan.sh`, then compiles the example the package ships) define what "passing" means. A change isn't verified until it has compiled clean in at least the matrix leg(s) it touches.

**`main.tex`'s option block is a CI dependency, not just an example.** `build-variants` mutates it with literal-string `sed` substitutions (e.g. `s/minted=false/minted=true/`). Don't reformat or reorder that block in a way that breaks those substitutions without updating `test.yaml` in the same change.

**Formatting constants cite the spec, not just a value.** `tongjithesis.cls` § Formatting Constants keeps derivation comments for values pulled from the official Tongji spec (e.g. `\tjinfoabstractspread`'s `18÷(12×1.2)=5/4`). When touching spacing/size constants, keep or update the derivation comment — it *is* the citation.

**`.editorconfig` conventions**: 2-space indent in `.cls`/`.sty`/`.tex`/`.cfg`; LF, UTF-8, trimmed trailing whitespace everywhere except `.bat` files (CRLF); tabs in `Makefile`.

**Quotation marks in Chinese prose use curly `“”`/`‘’` (U+201C/U+201D, U+2018/U+2019), always properly paired — never straight ASCII `"`/`'` and never the corner-bracket style `「」`/`『』`.** This applies to Chinese text in `.tex`/`.cls` comments and body content, and in Chinese `.md` prose. Exceptions: literal string-delimiter quotes inside code demos (`lstlisting`/`minted`/`verbatim`/`\verb|...|` — e.g. `print("Hello")` in `chapters/03_float.tex`) must stay as-is, since they're actual Python/C syntax, not Chinese punctuation; and a bare `'` inside math mode (`$f'(x)$`) is the prime/derivative symbol, not a quotation mark. When adding or editing Chinese text, grep for stray straight or corner-bracket quotes near CJK characters before committing.

**Bilingual docs follow one of two patterns — match whichever the file already uses.** `README.md`/`README-EN.md` are separate mirrored files (all-Chinese vs. all-English). `SECURITY.md` and the `.github/ISSUE_TEMPLATE`/PR templates are inline-bilingual at paragraph level (nearly every Chinese paragraph immediately followed by its full English translation — the PR template's checklist bullets are a Chinese-only exception). `CONTRIBUTING.md` is a third, weaker pattern: Chinese-only body text with only some section headers bilingual (`## 标题 | Title`) — don't assume it needs a paragraph-level English mirror; that's a known gap, not the target shape.

**Don't hand-edit build output.** `main.pdf` and `taskbook.pdf`/`proposal.pdf`/`midterm.pdf`, their `.{aux,bbl,bcf,fls,log,out,toc,xdv,synctex.gz}` siblings, `_minted*/`, `ctan/` are all generated (gitignored, or CI-only). If any of these appear tracked, or untracked-but-lingering in your working copy, they're clutter to leave alone, not something to edit or commit.

## Architecture

`tongjithesis.cls` loads `ctexbook` and layers Tongji-specific behavior on top, in banner-delimited (`% ====`) sections read top to bottom:

1. **Option Declaration** — `kvoptions`-based key-value options, declared in this order: `fontset`, `fullwidthstop`, `times`, `minted`, `biblatex`, `degree`, `field`, `algo`, `doctype` (`oneside`/`twoside` pass through to `ctexbook`). Parsed into `\iftongjithesis@*` conditionals (`bachelor`, `humanities`, `algorithmtwoe`, `doctype@taskbook`/`doctype@proposal`/`doctype@midterm`, plus `form` — set for any of the 3 form doctypes, for the many places where all three behave alike) that gate behavior throughout the rest of the file. `degree=master|doctor` (or any value other than `bachelor`) falls back to bachelor formatting with a `\ClassWarning` — reserved, not implemented. `doctype=thesis` (default) leaves the thesis flow untouched; `taskbook`/`proposal`/`midterm` select which standalone document `\MakeDocument` renders (item 9 below), and an unrecognized value falls back to `thesis` with a `\ClassWarning`.
2. **Class Loading** — `\LoadClass[UTF8,a4paper,zihao=-4,fontset=none]{ctexbook}`, then the fontset-specific CJK font `.def` is `\input`.
3. **Formatting Constants** — page geometry, font sizes, and spacing values transcribed from the official spec, most with a derivation comment.
4. **Required Packages** — third-party package loading.
5. **Bibliography Configuration** — the dual-backend split described in § Behavioral rules above. Sits immediately after Required Packages, *before* the page-layout/typography sections below — not appended at the end.
6. **General Configurations** — line-spread (`setstretch`), display-math skip lengths, float spacing, figure centering, `\AtEndOfClass{\raggedbottom}`.
7. **Page Layout / Typography and Font Settings / Lists and Enumerations / Table of Contents Formatting / Chapter-Section Numbering / Float Settings / Math and Theorem Environments / Algorithm and Code Listing Settings / Cross-Referencing Commands / Logo Commands** — the bulk of the class, each in its own banner section, in this order.
8. **Cover and User Information Commands** — `\school`, `\major`, `\student`, `\thesistitle{}{}`/`\thesistitleeng{}{}`, `\thesisadvisor`, `\thesisdate`, the optional `\abstracttitle`/`\abstracttitleeng`, and `\infotype`/`\infoabstract`/`\infomaterials`/`\infothesiswords`/`\infodrawings`+`\infowordcount` are the macros a writer calls in `chapters/metadata.tex`; `\MakeCover`, `\MakeInfoPage`, `\MakeAbstract`, `\MakeAbstractEng` consume them to typeset the cover, info page, and abstracts.
9. **Task Book / Proposal / Mid-term Report Commands** — `\taskbookperiod{startYear}{startMonth}{startDay}{endYear}{endMonth}{endDay}` (also called from `chapters/metadata.tex`, only meaningful for `doctype=taskbook`) computes the task book's week count from the date range; the shared layout primitives split into two groups by caller: `\tjformtable`, `\tjdateblank` and `\tjnumline` build the cover and subject-info table and are invoked only from the `\Make*` macros inside the `.cls`, while `\tjformnote`, `\tjformhint`, `\tjformsection`, `\tjformsubsection`, `\tjformnotice`, `tjformnoticebody`, `\tjformlabel`, `\tjformsignature` and `\tjreviewbox` are what the body files call, rather than setting `\heiti`/`\zihao` by hand; `\midtermdecision{agree|disagree}` presets the mid-term report's 专业审核意见 checkbox; `\MakeTaskBook`/`\MakeProposal`/`\MakeMidterm` render each document's cover/subject table, and `\MakeDocument` dispatches to one of them based on the `doctype` option (`\ClassError` if `doctype` is still `thesis`).
10. **Configuration Input** — the class ends by loading `tongjithesis.cfg`, the intended override point for local customization.

`main.tex` mirrors this at the document level, simplified (see `main.tex` itself for the `\cleardoublepage`/`\clearpage` calls between stages, and the commented-out `\listoffigures`/`\listoftables` opt-in toggles): `\documentclass[...]{tongjithesis}` → `\tjbibresource{...}` → `\input{chapters/metadata}` → `\MakeCover`/`\MakeInfoPage` → `\frontmatter` (abstract, TOC) → `\mainmatter` (chapters `01`–`06`) → `\makereferences` → `\appendix` (`chapters/appendix`) → `\backmatter` (acknowledgements). `taskbook.tex`/`proposal.tex`/`midterm.tex` mirror the same idea at a much shorter scale: `\documentclass[doctype=taskbook|proposal|midterm]{tongjithesis}` → `\input{chapters/metadata}` → `\MakeDocument` → `\input{chapters/{taskbook,proposal,midterm}_body}` — no frontmatter/mainmatter/bibliography stages.

Version identity is spread across `package.json` (`version`) and the `\ProvidesClass`/`\ProvidesFile` line in each of `style/tongjithesis.cls`, `style/tongjithesis.cfg`, `style/tongji-circled.def`, and `style/font/*.def` — kept in sync automatically by `release-please` (§ Branching and versioning), never by hand.

## Further reading

- `README.md` / `README-EN.md` — end-user quick start, class-option reference, font and code-highlighting setup.
- `CONTRIBUTING.md` — repository-structure summary for human contributors, PR process, contributor/project history.
- `SECURITY.md` — vulnerability reporting (template project: no network service or user data, so scope is CI/dependency risk only).
- `chapters/01_guide.tex` — the authoritative, compiled usage guide; consult it before writing new usage documentation elsewhere.
