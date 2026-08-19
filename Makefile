# Makefile for Tongji Thesis Template

###################
# Configuration
###################

# Basename of thesis
THESIS = main

# Basenames of the standalone administrative documents (task book, opening
# report, mid-term report) — each is its own tongjithesis document, sharing
# chapters/metadata.tex but selected via the doctype= class option.
FORMS = taskbook proposal midterm

# LaTeX engines options
ENGINES = -xelatex -lualatex
ENGINE ?= -xelatex  # Default engine to XeLaTeX

# Check for required programs
REQUIRED_PROGRAMS := latexmk texcount
$(foreach prog,$(REQUIRED_PROGRAMS),\
    $(if $(shell which $(prog)),,$(error "$(prog) not found in PATH")))

# Check if engine is valid
ifneq ($(filter all pvc thesis taskbook proposal midterm forms, $(MAKECMDGOALS)), )
    ifeq ($(filter $(ENGINES), $(ENGINE)), )
        $(info Error: Expected $$ENGINE in {$(ENGINES)}, Got "$(ENGINE)")
        $(info Setting default $$ENGINE to "-xelatex")
        override ENGINE = -xelatex
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
    -usepretex="\listfiles" \
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

.PHONY: all thesis pvc view wordcount clean cleanall help FORCE_MAKE forms taskbook proposal midterm

# Legacy alias
thesis: all

# Default target
all: $(THESIS).pdf

# Force remake (pattern rule: also matches taskbook.pdf/proposal.pdf/midterm.pdf below)
%.pdf: %.tex FORCE_MAKE
	@echo "Building $@ with $(ENGINE)..."
	@latexmk $(LATEXMK_OPT) $<

# Standalone administrative documents (task book / opening report / mid-term report)
taskbook: taskbook.pdf
proposal: proposal.pdf
midterm: midterm.pdf
forms: $(addsuffix .pdf,$(FORMS))

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
	-@latexmk -c -bibtex -silent $(THESIS).tex 2> /dev/null
	-@for f in $(FORMS); do latexmk -c -bibtex -silent $$f.tex 2> /dev/null; done
	@echo "Clean complete."

# Clean all generated files
cleanall:
	@echo "Cleaning all generated files..."
	-@latexmk -C -bibtex -silent $(THESIS).tex 2> /dev/null
	-@for f in $(FORMS); do latexmk -C -bibtex -silent $$f.tex 2> /dev/null; done
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
	@echo "  taskbook  - Build taskbook.pdf (毕业设计（论文）任务书)"
	@echo "  proposal  - Build proposal.pdf (毕业设计（论文）开题报告)"
	@echo "  midterm   - Build midterm.pdf (毕业设计（论文）中期报告)"
	@echo "  forms     - Build taskbook.pdf, proposal.pdf, and midterm.pdf"
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
	@echo "  make forms"

# Force remake
FORCE_MAKE:
