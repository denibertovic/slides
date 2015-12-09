IMAGE_NAME='denibertovic/presentation'


REVEALJS_TRANSITION=linear
REVEALJS_THEME=black
REVEALJS_URL=/reveal.js

PANDOC_CMD="pandoc -5 --slide-level=1 -t revealjs --highlight-style=zenburn -f markdown_github+mmd_title_block+backtick_code_blocks --standalone --self-contained --section-divs --variable transition=${REVEALJS_TRANSITION} --variable revealjs-url=${REVEALJS_URL} --variable theme=${REVEALJS_THEME} md/slides.md -o md/index.html"

.PHONY: build push run clean clean-html run-static

build:
	@docker build -t $(IMAGE_NAME) .

push:
	@echo "Not implemented yet."

run: clean
	@docker run -d \
		-v `pwd`/md:/reveal.js/md \
		-p 8000:8000 \
		-p 35729:35729 \
		--name presentation \
	$(IMAGE_NAME)

run-static: clean
	@docker run -d \
		-v `pwd`/md:/reveal.js/md \
		-p 8000:8000 \
		-p 35729:35729 \
		--name presentation \
	$(IMAGE_NAME) /bin/bash -c '"${PANDOC_CMD}" && cp md/index.html index.html && grunt serve'

bash:
	@docker run -it \
		-v `pwd`/md:/reveal.js/md \
	$(IMAGE_NAME) /bin/bash

clean:
	@-docker rm -v -f presentation

clean-html:
	@rm -f md/*.html

html: clean clean-html
	@docker run -d \
		-v `pwd`/md:/reveal.js/md \
		--name presentation \
	$(IMAGE_NAME) /bin/bash -c ${PANDOC_CMD}
	@echo "SUCCESS! Check md/index.html"

