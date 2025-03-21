#!/usr/bin/env perl

# LaTeXmk configuration file
# Documentation: https://ctan.math.washington.edu/tex-archive/support/latexmk/latexmk.pdf

###################
# Path Settings
###################
# Add paths for sections and other directories
ensure_path("TEXINPUTS", "./sections//");  # For section files
ensure_path("TEXINPUTS", "./figures//");   # For figure files
ensure_path("TEXINPUTS", "./style//");     # For style files
ensure_path("BIBINPUTS", "./bib//");       # For bibliography files

# Enable recursive scanning for included files
$recursive_dir_scan = 1;

###################
# Clean Settings
###################
# Keep the original clean extensions from the second file
# while adding some from the first file for better cleanup
$clean_ext = 'bbl glo gls gz hd loa run.xml thm xdv ' .
             'acn acr alg aux bcf fdb_latexmk fls ' .
             'ent ist lof lot nav out snm ' .
             'synctex.gz synctex(busy) toc vrb ' .
             '_minted-%R/* _minted-%R';

# Don't delete PDF files during cleanup
$clean_full_ext = '';

###################
# Build Settings
###################
$max_repeat = 5;

# Force directory creation if needed
system('mkdir -p sections figures style bib');
