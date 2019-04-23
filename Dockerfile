# vim: set syntax=dockerfile:

FROM ubuntu:bionic

ARG PANDOC_VERSION=2.7.1
ARG PANDOC_CROSSREF_VERSION=0.3.4.0d

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade --quiet --yes \
    && apt-get update --quiet \
    && apt-get install --quiet --yes \
        fonts-inconsolata \
        fonts-linuxlibertine \
        fonts-croscore \
        fonts-crosextra-carlito \
        fonts-texgyre \
        lmodern \
        locales \
        make \
        tex-gyre \
        texlive-fonts-extra \
        texlive-fonts-recommended \
        texlive-lang-french \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-science \
        texlive-xetex \
        tzdata \
        wget \
    && apt-get autoremove --quiet --yes \
    && apt-get clean \
    && wget https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb \
        -O pandoc.deb \
    && dpkg -i pandoc.deb \
    && wget https://github.com/lierdakil/pandoc-crossref/releases/download/v${PANDOC_CROSSREF_VERSION}/linux-pandoc_2_7.tar.gz \
        -O pandoc-crossref.tar.gz \
    && tar xf pandoc-crossref.tar.gz \
    && mv pandoc-crossref /usr/local/bin


# Set the locale
RUN locale-gen en_US
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Zurich /etc/localtime

# Create less privileged user
RUN groupadd --gid 1000 dev \
  && useradd --uid 1000 --gid dev --shell /bin/bash --create-home dev

# Mount your app source code directory into that folder
WORKDIR /home/dev/doc

# Fix permissions issues
RUN chmod -R a+wrx /home/dev/doc
RUN chmod -R a+wrx /usr/local/bin/pandoc-crossref

# Label schema related variables and metadata
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.vcs-url="https://github.com/groovytron/documentation-container" \
    org.label-schema.schema-version="1.0"
