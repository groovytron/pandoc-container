# Pandoc container

[![Build Status](https://travis-ci.org/groovytron/pandoc-container.svg?branch=master)](https://travis-ci.org/groovytron/pandoc-container)

Container embedding pandoc and some pandoc filter to convert files from a format to another.

## Softwares embedded in the container

- [curl](https://curl.haxx.se) to generate diagrams using a tool like [kroki](https://github.com/yuzutech/kroki)
- [inotify-tools](https://github.com/rvoicilas/inotify-tools) if you want to [rebuild your documentation on every file change with inotifywait](https://stackoverflow.com/a/23734495)
- `make`
- [pandoc](https://pandoc.org)
- [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref) filter
- [pandoc-include-code](https://github.com/owickstrom/pandoc-include-code) filter

## Use the container

We recommend you to use the `dev` user instead of `root` when running that container.

The container's working directory is `/home/dev/doc` so we advise you to mount your project's documentation directory onto this place.

### Building the project interactively in the container

To run the container and open a bash in your documentation project run the following command:

`docker run -it --entrypoint /bin/bash --user=dev --volume=<path-to-your-documentation-directory>:/home/dev/doc groovytron/pandoc:latest`
