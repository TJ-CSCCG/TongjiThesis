# about latexmk documentation
# see https://ctan.math.washington.edu/tex-archive/support/latexmk/latexmk.pdf

ensure_path("TEXINPUTS", "style");
ensure_path("BIBINPUTS", "bib");

# about latexmk -c
$clean_ext = 'bbl glo gls gz hd loa run.xml thm xdv';
