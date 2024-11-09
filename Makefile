MAIN_FILE := User-Group-HOWTO.tex
DOC_CLASS := HOWTO.cls
TEX_FILES := $(shell find sections/ -type f -iname '*.tex')

OUTPUT_DIRECTORIY := out
PDF_FILE := ${OUTPUT_DIRECTORIY}/${MAIN_FILE:%.tex=%.pdf}

XELATEX_FLAGS := -output-directory=${OUTPUT_DIRECTORIY} -file-line-error -halt-on-error -interaction nonstopmode

all: ${PDF_FILE}

${PDF_FILE}: ${MAIN_FILE} ${DOC_CLASS} ${TEX_FILES} ${OUTPUT_DIRECTORIY}
	xelatex ${XELATEX_FLAGS} ${MAIN_FILE}
	xelatex ${XELATEX_FLAGS} ${MAIN_FILE}

${OUTPUT_DIRECTORIY}:
	mkdir -p ${OUTPUT_DIRECTORIY}

view: ${PDF_FILE}
	@xdg-open ${PDF_FILE}

clean:
	@rm -rvf ${OUTPUT_DIRECTORIY}

.PHONY: clean view
