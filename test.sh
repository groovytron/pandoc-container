#!/bin/bash

docker run -it \
    --user dev \
    doc-container:latest \
    bash -c "git clone https://github.com/HE-Arc/rapport-technique.git && cd rapport-technique && make"
