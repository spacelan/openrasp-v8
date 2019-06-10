#!/bin/bash

set -ex

mkdir build64 && pushd $_

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../java

make VERBOSE=1 -j

popd

mkdir -p java/src/main/resources/natives/osx_64 && cp build64/libopenrasp_v8_java.dylib $_

pushd java

mvn test

popd

pushd java/src/main/resources

tar zcf java_natives_osx.tar.gz natives/osx*

popd