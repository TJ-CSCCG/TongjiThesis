# Latexmk configuration file.
#
#   WARNING: Only works with version 4.59 or higher of latexmk.
#

# PDF generate method:
#   - 1 pdfLaTeX
#   - 3 LaTeX + DVIPDFMx
#   - 4 LuaLaTeX
#   - 5 XeLaTeX
$pdf_mode = 5;

# Add common patterns for tex engines.
set_tex_cmds( '-synctex=1 -interaction=nonstopmode %O %S' );

# Use xdvipdfmx to convert .xdv to .pdf, always try to embed fonts.
$xdvipdfmx = 'xdvipdfmx -E -o %D %S';

# Run biber whenever it appears necessary, always delete .bbl files in a cleanup.
$bibtex_use = 2;

# Maximum number of compilation passes.
$max_repeat = 5;

###################
# Path Settings
###################
# Prepended local directories to the search paths.
ensure_path( 'TEXINPUTS', './style//' );
ensure_path( 'TEXINPUTS', './chapters//' );
ensure_path( 'TEXINPUTS', './figures//' );
ensure_path( 'BIBINPUTS', './bib//' );

# Enable recursive scanning for included files.
$recursive_dir_scan = 1;

###################
# Clean Settings
###################
$clean_ext  = 'bbl glo gls gz hd loa run.xml thm xdv ';
$clean_ext .= 'acn acr alg aux bcf fdb_latexmk fls ';
$clean_ext .= 'ent ist lof lot nav out snm ';
$clean_ext .= 'synctex.gz synctex(busy) toc vrb ';
$clean_ext .= '_minted-%R/* _minted-%R _minted/* _minted';

# Don't delete PDF files during cleanup.
$clean_full_ext = '';

# Ensure required directories exist.
use File::Path qw(make_path);
make_path( 'chapters', 'figures', 'style', 'bib' );
