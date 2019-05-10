#!/bin/bash

set -ex

mkdir build && pushd build

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -Ax64 ../base

cmake --build . --config Debug

cmake --build . --config Release

./Debug/tests "~Exception"

./Release/tests "~Exception"

rm -rf ./*

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -Ax86 -DCMAKE_PREFIX_PATH=../vendors/libv8-7.2-windows-x86 ../base

cmake --build . --config Debug

cmake --build . --config Release

./Debug/tests "~Exception"

./Release/tests "~Exception"