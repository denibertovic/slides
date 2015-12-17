IMAGE_NAME='denibertovic/slides'


REVEALJS_TRANSITION?=linear
REVEALJS_THEME?=black
REVEALJS_URL=/opt/slides/reveal.js

PANDOC_CMD_PRESENT="pandoc -5 --slide-level=1 -t revealjs --highlight-style=zenburn -f markdown_github+mmd_title_block+backtick_code_blocks --standalone --self-contained --section-divs --variable transition=${REVEALJS_TRANSITION} --variable revealjs-url=${REVEALJS_URL} --variable theme=${REVEALJS_THEME} md/slides.md -o out/index.html"

PANDOC_CMD_PDF="pandoc --slide-level=1 -t latex --highlight-style=zenburn -f markdown_github+mmd_title_block+backtick_code_blocks --standalone --self-contained --section-divs md/slides.md -o out/out.pdf"

.PHONY: run prompt clean clean-html html pdf present logs

LOCAL_USER_ID ?= $(shell id -u $$USER)

run: clean
	@docker run -d \
		-e LOCAL_USER_ID=${LOCAL_USER_ID} \
		-v `pwd`/md:/opt/slides/reveal.js/md \
		-p 8000:8000 \
		-p 35729:35729 \
		--name presentation \
	$(IMAGE_NAME)
	@echo "\n\nServer launched. Visit http://localhost:8000 to view slides.\n"

prompt:
	@docker run -it \
		-e LOCAL_USER_ID=${LOCAL_USER_ID} \
 		-v `pwd`/out:/opt/slides/reveal.js/out \
		-v `pwd`/md:/opt/slides/reveal.js/md \
	$(IMAGE_NAME) /bin/bash

clean: clean-html
	@-docker rm -v -f presentation

clean-html:
	@rm -rf out

html: clean
	@docker run -d \
		-e LOCAL_USER_ID=${LOCAL_USER_ID} \
 		-v `pwd`/md:/opt/slides/reveal.js/md \
 		-v `pwd`/out:/opt/slides/reveal.js/out \
		--name presentation \
	$(IMAGE_NAME) /bin/bash -c ${PANDOC_CMD_PRESENT}
	@echo "\n\nSUCCESS! Check out/index.html\n"

pdf: clean
	@docker run -d \
		-e LOCAL_USER_ID=${LOCAL_USER_ID} \
 		-v `pwd`/md:/opt/slides/reveal.js/md \
 		-v `pwd`/out:/opt/slides/reveal.js/out \
		--name presentation \
	$(IMAGE_NAME) /bin/bash -c ${PANDOC_CMD_PDF}
	@echo "\n\nSUCCESS! PDF created in out/out.pdf\n"

present:
	@google-chrome --incognito out/index.html

logs:
	@docker logs presentation

