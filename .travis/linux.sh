
#!/bin/bash

set -ex

tar zxf vendors/centos6-sysroot.tar.gz -C /tmp/

mkdir build64 && pushd $_

(source /tmp/centos6-sysroot/setx64.sh && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../java)

make VERBOSE=1 -j

popd

mkdir build32 && pushd $_

(source /tmp/centos6-sysroot/setx86.sh && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../java)

make VERBOSE=1 -j

popd

mkdir -p java/src/main/resources/natives/linux_32 && cp build32/libopenrasp_v8_java.so $_

mkdir -p java/src/main/resources/natives/linux_64 && cp build64/libopenrasp_v8_java.so $_

pushd java

mvn test

popd

pushd java/src/main/resources

tar zcf java_natives_linux.tar.gz natives/linux*

popd