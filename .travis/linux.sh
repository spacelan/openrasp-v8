#!/bin/bash

set -ex

mkdir buildx64 && pushd buildx64

cmake -DCMAKE_BUILD_TYPE=Release ../base

make VERBOSE=1 -j

make test

popd

mkdir buildx32 && pushd buildx32

cmake -DCMAKE_CXX_FLAGS="-m32" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="../vendors/libv8-7.2-linux-x86;../vendors/libc++-linux-x86" ../base

make VERBOSE=1 -j

make test

popd