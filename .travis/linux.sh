
#!/bin/bash

set -ex

tar zxf vendors/centos6-sysroot.tar.gz -C /tmp/

mkdir buildx64 && pushd buildx64

(source /tmp/centos6-sysroot/setx64.sh && cmake ../base)

make VERBOSE=1 -j

make test

popd

mkdir buildx32 && pushd buildx32

(source /tmp/centos6-sysroot/setx86.sh && cmake -DCMAKE_CXX_FLAGS="-m32 $CXXFLAGS" -DCMAKE_PREFIX_PATH="../vendors/libc++-linux-x86;../vendors/libv8-7.2-linux-x86" ../base)

make VERBOSE=1 -j

make test

popd

mkdir dist

cp buildx64/tests dist/test-linux-x64

cp buildx32/tests dist/test-linux-x32