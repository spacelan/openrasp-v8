#!/bin/bash

set -ex

mkdir buildx64 && pushd buildx64

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../java

make VERBOSE=1 -j

popd

mkdir dist

cp buildx64/libopenrasp_v8_java.dylib dist/libopenrasp_v8_java.dylib