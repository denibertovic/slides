IMAGE_NAME='denibertovic/presentation'

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
	$(IMAGE_NAME) /bin/bash -c "pandoc -t html5 --template=pandoc-template-revealjs.html --self-contained  --section-divs --variable theme="black" --variable transition="concave" md/slides.md -o md/index.html && cp md/index.html index.html && grunt serve"

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
	$(IMAGE_NAME) /bin/bash -c "pandoc -t html5 --template=pandoc-template-revealjs.html --self-contained  --section-divs --variable theme="black" --variable transition="concave" md/slides.md -o md/index.html"
	@echo "SUCCESS! Check md/index.html"

