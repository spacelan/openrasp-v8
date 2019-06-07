#!/bin/bash

set -ex

mkdir build64 && pushd $_

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../java

make VERBOSE=1 -j

popd

pushd java/src/main/resources

mkdir -p natives/osx_64 && cp ${TRAVIS_BUILD_DIR}/build64/libopenrasp_v8_java.dylib $_

tar zcf java_natives_osx.tar.gz natives

popd

pushd java

mvn test