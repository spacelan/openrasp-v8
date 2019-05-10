#!/bin/bash

set -ex

mkdir buildx64 && pushd buildx64

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -Ax64 ../base

cmake --build . --config Release

./Release/tests "~Exception"

popd

mkdir buildx32 && pushd buildx32

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_PREFIX_PATH="../vendors/libv8-7.2-windows-x86"  ../base

cmake --build . --config Release

./Release/tests "~Exception"

popd