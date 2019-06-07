
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

pushd java/src/main/resources

mkdir -p natives/linux_32 && cp ${TRAVIS_BUILD_DIR}/build32/libopenrasp_v8_java.so $_
mkdir -p natives/linux_64 && cp ${TRAVIS_BUILD_DIR}/build64/libopenrasp_v8_java.so $_

tar zcf java_natives_linux.tar.gz natives

popd

pushd java

mvn test