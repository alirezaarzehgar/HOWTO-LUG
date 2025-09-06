MAIN_FILE := User-Group-HOWTO.tex
DOC_CLASS := HOWTO.cls
TEX_FILES := $(shell find sections/ -type f -iname '*.tex')

OUTPUT_DIRECTORY := out
PDF_FILE := ${OUTPUT_DIRECTORY}/${MAIN_FILE:%.tex=%.pdf}

XELATEX_FLAGS := -output-directory=${OUTPUT_DIRECTORY} -file-line-error -halt-on-error -interaction nonstopmode

all: ${PDF_FILE}

${PDF_FILE}: ${MAIN_FILE} ${DOC_CLASS} ${TEX_FILES} ${OUTPUT_DIRECTORY}
	xelatex ${XELATEX_FLAGS} ${MAIN_FILE}
	xelatex ${XELATEX_FLAGS} ${MAIN_FILE}

${OUTPUT_DIRECTORY}:
	mkdir -p ${OUTPUT_DIRECTORY}

view: ${PDF_FILE}
	@xdg-open ${PDF_FILE}

web-build:
	latexpand ${MAIN_FILE} > ${OUTPUT_DIRECTORY}/output.tex
	sed -i "s/\\\LRE{\([^{}]*\)}/\1/g" ${OUTPUT_DIRECTORY}/output.tex
	pandoc -s --toc ${OUTPUT_DIRECTORY}/output.tex -o ${OUTPUT_DIRECTORY}/index.html
	sed -i -e '/<style>/ {' -e 's/<style>/<style>/g' -e 'r styles.css' -e '}' ${OUTPUT_DIRECTORY}/index.html

clean:
	@rm -rvf ${OUTPUT_DIRECTORY}

.PHONY: clean view
