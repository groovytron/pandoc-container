#!/bin/bash

git clone https://github.com/HE-Arc/rapport-technique.git || return 1
cd rapport-technique || return 1
make || return 1
