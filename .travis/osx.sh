#!/bin/bash

set -ex

mkdir buildx64 && pushd buildx64

cmake -DCMAKE_BUILD_TYPE=Release ../base

make VERBOSE=1 -j

make test

popd