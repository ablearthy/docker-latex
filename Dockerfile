FROM docker.io/library/debian:13-slim

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV WORK_DIR /document

VOLUME $WORK_DIR
WORKDIR $WORK_DIR

COPY debian.sources /etc/apt/sources.list.d/debian.sources

RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

RUN apt update && \
    apt install --no-install-recommends -y \
        wget \
        git \
        make \
        apt-transport-https \
        unzip \
        texlive-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-lang-cyrillic \
        texlive-science \
        texlive-latex-recommended \
        latexmk \
	gnuplot \
	ttf-mscorefonts-installer \
        fonts-freefont-ttf \
        fontconfig

RUN wget https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip && \
    unzip -o XITS-1.302.zip -d /usr/share/fonts/ && \
    rm -f XITS-1.302.zip && \
    rm -rf /usr/share/fonts/XITS-1.302/webfonts && \
    fc-cache -f -v

RUN wget https://github.com/be5invis/Iosevka/releases/download/v33.3.0/PkgTTC-Iosevka-33.3.0.zip && \
    unzip -o PkgTTC-Iosevka-33.3.0.zip -d /usr/share/fonts/ && \
    rm -f PkgTTC-Iosevka-33.3.0.zip && \
    fc-cache -f -v

RUN apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
