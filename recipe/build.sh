#!/bin/sh
set -ex

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
             -DBUILD_CursesDialog=ON
make install -j${CPU_COUNT}
