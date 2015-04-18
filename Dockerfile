# RevealJS
# Version 3.0.0

FROM node

MAINTAINER Deni Bertovic <deni@denibertovic.com>

ENV REVEALJS_VERSION 3.0.0

# RUN git clone https://github.com/hakimel/reveal.js.git /revealjs
RUN wget https://github.com/hakimel/reveal.js/archive/$REVEALJS_VERSION.tar.gz -O /tmp/$REVEALJS_VERSION.tar.gz 2> /dev/null
RUN tar zxvf /tmp/$REVEALJS_VERSION.tar.gz -C / && rm /tmp/$REVEALJS_VERSION.tar.gz && mv /reveal.js-$REVEALJS_VERSION /revealjs
RUN cd /revealjs
RUN mkdir -p /revealjs/md

WORKDIR /revealjs

RUN npm install -g grunt-cli && npm install
RUN sed -i Gruntfile.js -e 's/port: port,/port: port, hostname: "",/'

ADD index.html /revealjs/
ADD title.js /revealjs/plugin/
ADD test_slides.md /revealjs/md/slides.md

EXPOSE 8000
EXPOSE 35729

VOLUME ["/revealjs/md/"]

CMD ["grunt", "serve"]

