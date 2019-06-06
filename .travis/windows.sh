#!/bin/bash

set -ex

choco install -y jdk8 -params "both=true"

mkdir build64 && pushd $_

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -Ax64 ../java

cmake --build . --config RelWithDebInfo

popd

mkdir build32 && pushd $_

cmake -DCMAKE_VERBOSE_MAKEFILE=ON ../java

cmake --build . --config RelWithDebInfo

popd

mkdir dist && pushd $_

mkdir -p natives/windows_32 && cp ../build32/RelWithDebInfo/openrasp_v8_java.dll $_
mkdir -p natives/windows_64 && cp ../build64/RelWithDebInfo/openrasp_v8_java.dll $_

tar zcf java_natives_windows.tar.gz natives

rm -rf natives