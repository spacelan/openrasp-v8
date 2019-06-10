#!/bin/bash

set -ex

choco install -y jdk8 -params "both=true"

choco install -y maven

mkdir build64 && pushd $_

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -Ax64 ../java

cmake --build . --config RelWithDebInfo

popd

mkdir build32 && pushd $_

cmake -DCMAKE_VERBOSE_MAKEFILE=ON ../java

cmake --build . --config RelWithDebInfo

popd

mkdir -p java/src/main/resources/natives/windows_32 && cp build32/RelWithDebInfo/openrasp_v8_java.dll $_

mkdir -p java/src/main/resources/natives/windows_64 && cp build64/RelWithDebInfo/openrasp_v8_java.dll $_

pushd java

JAVA_HOME="/c/Program Files (x86)/Java/jdk1.8.0_211" mvn test

JAVA_HOME="/c/Program Files/Java/jdk1.8.0_211" mvn test

popd

pushd java/src/main/resources

tar zcf java_natives_windows.tar.gz natives

popd