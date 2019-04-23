#!/bin/bash

docker run -it -v $(pwd)/rapport-technique:/home/dev/doc --user dev doc-container:latest make
