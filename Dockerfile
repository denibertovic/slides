# RevealJS
FROM node:4.2

MAINTAINER Deni Bertovic <deni@denibertovic.com>

RUN apt-get update && apt-get -y --no-install-suggests install \
    pandoc \
    texlive-fonts-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended

# Install PID1
ENV PID1_VERSION=0.1.2.0
RUN curl -sSL "https://github.com/fpco/pid1/releases/download/v${PID1_VERSION}/pid1-${PID1_VERSION}-linux-x86_64.tar.gz" | tar xzf - -C /usr/local && \
    chown root:root /usr/local/sbin && \
    chown root:root /usr/local/sbin/pid1
ENV LANG=en_US.UTF-8

ENV REVEALJS_VERSION 3.2.0
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
RUN grunt --force

COPY index.html /opt/slides/reveal.js/
COPY example/md /opt/slides/reveal.js/md
COPY pandoc_templates/default.revealjs /usr/share/pandoc/data/templates/default.revealjs
COPY pandoc_templates/default.latex /usr/share/pandoc/data/templates/default.latex

EXPOSE 8000
EXPOSE 35729

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["grunt", "serve"]
