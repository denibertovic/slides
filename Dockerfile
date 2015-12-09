# RevealJS
# Version 3.2.0

FROM node

MAINTAINER Deni Bertovic <deni@denibertovic.com>

ENV REVEALJS_VERSION 3.2.0

RUN apt-get update && apt-get -y install pandoc

RUN wget https://github.com/hakimel/reveal.js/archive/$REVEALJS_VERSION.tar.gz \
    -O /tmp/$REVEALJS_VERSION.tar.gz 2> /dev/null \
    && tar zxvf /tmp/$REVEALJS_VERSION.tar.gz -C / \
    && rm /tmp/$REVEALJS_VERSION.tar.gz \
    && mv /reveal.js-$REVEALJS_VERSION /reveal.js

RUN cd /reveal.js && mkdir -p /reveal.js/md

WORKDIR /reveal.js

RUN npm install -g grunt-cli && npm install
RUN sed -i Gruntfile.js -e 's/port: port,/port: port, hostname: "",/'
RUN grunt

COPY index.html /reveal.js/
COPY title.js /reveal.js/plugin/
COPY test_slides.md /reveal.js/md/slides.md
COPY pandoc-template-revealjs.html /reveal.js/pandoc-template-revealjs.html

EXPOSE 8000
EXPOSE 35729

CMD ["grunt", "serve"]

