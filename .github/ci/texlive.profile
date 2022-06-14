# From latex3 & fduthesis
# https://github.com/latex3/latex3/blob/main/support/texlive.profile
# https://github.com/stone-zeng/fduthesis/blob/main/.github/workflows/texlive.profile

selected_scheme     scheme-infraonly
TEXDIR              /tmp/texlive
TEXMFSYSCONFIG      /tmp/texlive/texmf-config
TEXMFSYSVAR         /tmp/texlive/texmf-var
TEXMFLOCAL          /tmp/texlive/texmf-local
TEXMFHOME           ~/texmf
TEXMFCONFIG         ~/.texlive/texmf-config
TEXMFVAR            ~/.texlive/texmf-var
option_doc          0
option_src          0
tlpdbopt_autobackup 0