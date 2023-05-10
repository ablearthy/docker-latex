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
        texlive-science \
        texlive-latex-recommended \
        latexmk \
        libcerf-dev \
        gfortran \
        libwebp-dev \
        adwaita-icon-theme-full

RUN apt install --no-install-recommends -y automake autotools-dev

RUN git clone -b branch-6-0-stable --single-branch git://git.code.sf.net/p/gnuplot/gnuplot-main gnuplot-gnuplot-main && \
    cd gnuplot-gnuplot-main && \
    git checkout d165a028c9446e57a3dc1ff9c8d1056e6ace519e && \
    ./prepare && \
    ./configure && \
    make -j && \
    make install


RUN apt install --no-install-recommends --reinstall -y \
        ttf-mscorefonts-installer \
        fonts-freefont-ttf \
        fontconfig && \
    wget https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip && \
    unzip -o XITS-1.302.zip -d /usr/share/fonts/ && \
    rm -f XITS-1.302.zip && \
    rm -rf /usr/share/fonts/XITS-1.302/webfonts && \
    fc-cache -f -v
