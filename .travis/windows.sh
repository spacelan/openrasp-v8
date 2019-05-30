#!/bin/bash

set -ex

choco install -y jdk8 -params "both=true"

mkdir buildx64 && pushd buildx64

cmake -DCMAKE_VERBOSE_MAKEFILE=ON -Ax64 ../java

cmake --build . --config Release

popd

mkdir buildx86 && pushd buildx86

cmake -DCMAKE_VERBOSE_MAKEFILE=ON ../java

cmake --build . --config Release

popd

mkdir dist

cp buildx64/Release/openrasp_v8_java.dll dist/openrasp_v8_java.dll

cp buildx86/Release/openrasp_v8_java.dll dist/openrasp_v8_java.dll.x86