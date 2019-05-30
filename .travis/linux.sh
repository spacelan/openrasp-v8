
#!/bin/bash

set -ex

tar zxf vendors/centos6-sysroot.tar.gz -C /tmp/

mkdir buildx64 && pushd buildx64

(source /tmp/centos6-sysroot/setx64.sh && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../java)

make VERBOSE=1 -j

popd

mkdir buildx86 && pushd buildx86

(source /tmp/centos6-sysroot/setx86.sh && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_FLAGS="-m32 $CXXFLAGS" ../java)

make VERBOSE=1 -j

popd

mkdir dist

cp buildx64/libopenrasp_v8_java.so dist/libopenrasp_v8_java.so

cp buildx86/libopenrasp_v8_java.so dist/libopenrasp_v8_java.so.x86