#!/bin/sh

export VERBOSE=1
./bootstrap \
             --verbose \
             --prefix="${PREFIX}" \
             --system-libs \
             --system-libuv \
             --no-qt-gui \
             --no-system-libarchive \
             --no-system-jsoncpp \
             --parallel=${CPU_COUNT} \
             -- \
             -DCMAKE_BUILD_TYPE:STRING=Release \
             -DCMAKE_FIND_ROOT_PATH="${PREFIX}" \
             -DCMAKE_INSTALL_RPATH="${PREFIX}/lib"
make install -j${CPU_COUNT}
