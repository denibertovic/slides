# RevealJS

FROM node

MAINTAINER Deni Bertovic <deni@denibertovic.com>

ENV REVEALJS_VERSION 3.2.0

RUN apt-get update && apt-get -y --no-install-suggests install \
    pandoc

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN wget "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    -O /usr/local/bin/gosu 2> /dev/null \
    && wget "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    -O /usr/local/bin/gosu.asc 2> /dev/null \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN wget https://github.com/hakimel/reveal.js/archive/$REVEALJS_VERSION.tar.gz \
    -O /tmp/$REVEALJS_VERSION.tar.gz 2> /dev/null \
    && mkdir /opt/slides \
    && tar zxvf /tmp/$REVEALJS_VERSION.tar.gz -C /opt/slides \
    && rm /tmp/$REVEALJS_VERSION.tar.gz \
    && mv /opt/slides/reveal.js-$REVEALJS_VERSION /opt/slides/reveal.js

RUN cd /opt/slides/reveal.js && mkdir -p /opt/slides/reveal.js/md

WORKDIR /opt/slides/reveal.js

RUN npm install -g grunt-cli && npm install
RUN sed -i Gruntfile.js -e 's/port: port,/port: port, hostname: "",/'
RUN grunt

COPY index.html /opt/slides/reveal.js/
COPY test_slides.md /opt/slides/reveal.js/md/slides.md
COPY default.revealjs /usr/share/pandoc/data/templates/default.revealjs

EXPOSE 8000
EXPOSE 35729

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["grunt", "serve"]

