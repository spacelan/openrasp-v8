#!/bin/bash

set -ex

mkdir build64 && pushd $_

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../java

make VERBOSE=1 -j

popd

mkdir dist && pushd $_

mkdir -p natives/osx_64 && cp ../build64/libopenrasp_v8_java.dylib $_

tar zcf java_natives_osx.tar.gz natives

rm -rf natives