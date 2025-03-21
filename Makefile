# Makefile for Tongji Thesis Template

###################
# Configuration
###################

# Basename of thesis
THESIS = main

# LaTeX engines options
ENGINES = -xelatex -lualatex
ENGINE ?= -xelatex  # Default engine to XeLaTeX

# Check for required programs
REQUIRED_PROGRAMS := latexmk texcount
$(foreach prog,$(REQUIRED_PROGRAMS),\
    $(if $(shell which $(prog)),,$(error "$(prog) not found in PATH")))

# Check if engine is valid
ifneq ($(filter all pvc, $(MAKECMDGOALS)), )
    ifeq ($(filter $(ENGINES), $(ENGINE)), )
        $(info Error: Expected $$ENGINE in {$(ENGINES)}, Got "$(ENGINE)")
        $(info Setting default $$ENGINE to "-xelatex")
        ENGINE = -xelatex
    endif
endif

# LaTeXmk options
LATEXMK_OPT = \
    -quiet \
    -file-line-error \
    -halt-on-error \
    -interaction=nonstopmode \
    -shell-escape \
    -synctex=1 \
    -recorder \
    $(ENGINE)

# Preview continuous mode options
LATEXMK_OPT_PVC = $(LATEXMK_OPT) -pvc

###################
# OS Detection
###################

# Detect OS and set commands accordingly
ifdef SystemRoot
    # Windows
    RM = del /Q
    RMDIR = rmdir /S /Q
    MKDIR = mkdir
    OPEN = start
else
    # Unix-like systems (Linux, macOS)
    RM = rm -f
    RMDIR = rm -rf
    MKDIR = mkdir -p
    ifeq ($(shell uname),Darwin)
        # macOS
        OPEN = open
    else
        # Linux and others
        OPEN = xdg-open
    endif
endif

###################
# Targets
###################

.PHONY: all pvc view wordcount clean cleanall help FORCE_MAKE

# Default target
all: $(THESIS).pdf

# Force remake
$(THESIS).pdf: $(THESIS).tex FORCE_MAKE
	@echo "Building $(THESIS).pdf with $(ENGINE)..."
	@latexmk $(LATEXMK_OPT) $<

# Preview continuous mode
pvc: $(THESIS).tex
	@echo "Starting preview continuous mode..."
	@latexmk $(LATEXMK_OPT_PVC) $(THESIS)

# View PDF
view: $(THESIS).pdf
	@echo "Opening $(THESIS).pdf..."
	$(OPEN) $<

# Word count
wordcount: $(THESIS).tex
	@echo "Counting words in $(THESIS).tex..."
	@if grep -v ^% $< | grep -q '\\documentclass\[[^\[]*english'; then \
		texcount $< -inc -char-only | awk '/total/ {getline; print "英文字符数 (Latin characters)\t:",$$4}'; \
	else \
		texcount $< -inc -ch-only   | awk '/total/ {getline; print "纯中文字数 (Chinese characters)\t:",$$4}'; \
	fi
	@texcount $< -inc -chinese | awk '/total/ {getline; print "总字数 (Total characters)\t:",$$4}'

# Clean auxiliary files
clean:
	@echo "Cleaning auxiliary files..."
	-@latexmk -c -bibtex -silent $(THESIS).tex styledef.tex 2> /dev/null
	@echo "Clean complete."

# Clean all generated files
cleanall:
	@echo "Cleaning all generated files..."
	-@latexmk -C -bibtex -silent $(THESIS).tex styledef.tex 2> /dev/null
	@echo "Clean complete."

# Help target
help:
	@echo "Available targets:"
	@echo "  all       - Build PDF (default)"
	@echo "  pvc       - Preview continuously"
	@echo "  view      - Open PDF"
	@echo "  wordcount - Count words in Chinese and English"
	@echo "  clean     - Remove auxiliary files"
	@echo "  cleanall  - Remove all generated files"
	@echo "  help      - Show this help message"
	@echo ""
	@echo "Available engines (use ENGINE=<option>):"
	@echo "  -xelatex (default)"
	@echo "  -lualatex"
	@echo ""
	@echo "Example usage:"
	@echo "  make"
	@echo "  make ENGINE=-lualatex"
	@echo "  make pvc"

# Force remake
FORCE_MAKE:
