# vim: set syntax=dockerfile:

FROM ubuntu:bionic

ARG PANDOC_VERSION
ARG PANDOC_CROSSREF_VERSION
ARG PANDOC_INCLUDE_CODE_VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade --quiet --yes \
    && apt-get update --quiet \
    && apt-get install --quiet --yes \
        bash-completion \
        curl \
        fonts-inconsolata \
        fonts-linuxlibertine \
        fonts-croscore \
        fonts-crosextra-carlito \
        fonts-texgyre \
        git \
        inotify-tools \
        lmodern \
        locales \
        librsvg2-bin \
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
        --output-document pandoc.deb \
        --quiet \
    && dpkg -i pandoc.deb \
    && rm pandoc.deb \
    && wget https://github.com/lierdakil/pandoc-crossref/releases/download/v${PANDOC_CROSSREF_VERSION}/linux-pandoc_2_7.tar.gz \
        --output-document pandoc-crossref.tar.gz \
        --quiet \
    && tar xf pandoc-crossref.tar.gz \
    && mv pandoc-crossref /usr/local/bin \
    && wget https://github.com/owickstrom/pandoc-include-code/releases/download/v${PANDOC_INCLUDE_CODE_VERSION}/pandoc-include-code-linux-ghc8-pandoc-1-19.tar.gz \
        --output-document pandoc-include-code.tar.gz \
        --quiet \
    && tar xf pandoc-include-code.tar.gz \
    && mv pandoc-include-code /usr/local/bin

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

# Add bash completion
RUN echo 'source /etc/profile.d/bash_completion.sh' >> ~/.bashrc
RUN echo 'source /etc/profile.d/bash_completion.sh' >> /home/dev/.bashrc

# Fix permissions issues
RUN chmod -R a+wrx /home/dev
RUN chmod -R a+rx /usr/local/bin/pandoc-crossref
RUN chmod -R a+rx /usr/local/bin/pandoc-include-code

# Label schema related variables and metadata
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.vcs-url="https://github.com/groovytron/pandoc-container" \
    org.label-schema.schema-version="1.0" \
    org.opencontainers.image.authors="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.description="Container embedding pandoc and some pandoc filters to build documentation" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.revision=${VCS_REF} \
    org.opencontainers.image.source="https://github.com/groovytron/pandoc-container" \
    org.opencontainers.image.title="Pandoc Container" \
    org.opencontainers.image.url="https://github.com/groovytron/pandoc-container" \
    org.opencontainers.image.vendor="Julien M'Poy <julien.mpoy@gmail.com>" \
    org.opencontainers.image.version="2.7.2"
