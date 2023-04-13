FROM ubuntu:23.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV WORK_DIR /document

VOLUME $WORK_DIR
WORKDIR $WORK_DIR

RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

RUN apt update && \
    apt install --no-install-recommends -y \
        wget \
        git \
        make \
        apt-transport-https \
        unzip && \
    apt install --no-install-recommends -y \
        texlive-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-lang-cyrillic \
        texlive-fonts-extra \
        texlive-science \
        texlive-latex-recommended \
        latexmk

RUN apt install --no-install-recommends --reinstall -y \
        ttf-mscorefonts-installer \
        fonts-freefont-ttf \
        fontconfig && \
    wget https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip && \
    unzip -o XITS-1.302.zip -d /usr/share/fonts/ && \
    rm -f XITS-1.302.zip && \
    fc-cache -f -v
