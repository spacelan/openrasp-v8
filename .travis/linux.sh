#!/bin/bash

set -ex

mkdir build && pushd build

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_BUILD_TYPE=Release ../base

make

make test