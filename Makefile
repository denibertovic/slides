IMAGE_NAME='denibertovic/slides'


REVEALJS_TRANSITION=linear
REVEALJS_THEME=black
REVEALJS_URL=/opt/slides/reveal.js

PANDOC_CMD="pandoc -5 --slide-level=1 -t revealjs --highlight-style=zenburn -f markdown_github+mmd_title_block+backtick_code_blocks --standalone --self-contained --section-divs --variable transition=${REVEALJS_TRANSITION} --variable revealjs-url=${REVEALJS_URL} --variable theme=${REVEALJS_THEME} md/slides.md -o out/index.html"

.PHONY: build push new-slides

LOCAL_USER_ID ?= $(shell id -u $$USER)

include new_slides_project/Makefile

build:
	@docker build -t $(IMAGE_NAME) .

push:
	@docker push $(IMAGE_NAME)

new-slides:
	@mkdir -p $(NEW_SLIDES_PATH)
	@cp -r new_slides_project/* $(NEW_SLIDES_PATH) && cp -r md $(NEW_SLIDES_PATH)

