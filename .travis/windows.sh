#!/bin/bash

set -ex

mkdir build && pushd build

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -Ax64 ../base

cmake --build . --config Release

./Release/tests "~Exception"