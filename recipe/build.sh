#!/bin/sh
set -ex

if [[ "$target_platform" == osx* ]]; then
  # When MACOSX_DEPLOYMENT_TARGET is set to 10.9, libc++ headers
  # will only use symbols from libc++.dylib version shipped in 10.9
  # and error out if newer features are used.
  # Since we are using our own libc++.dylib, we don't have that
  # restriction. Setting _LIBCPP_DISABLE_AVAILABILITY removes this
  # error. This flag might be best added in the compiler activation
  # package, but it's safe keeping this just for this recipe until
  # the consequences are understood
  # See https://bugzilla.mozilla.org/show_bug.cgi?id=1573733
  export CPPFLAGS="$CPPFLAGS -D_LIBCPP_DISABLE_AVAILABILITY=1"
  export CFLAGS="$CFLAGS -D_LIBCPP_DISABLE_AVAILABILITY=1"
  export CXXFLAGS="$CXXFLAGS -D_LIBCPP_DISABLE_AVAILABILITY=1"
fi

./bootstrap \
             --verbose \
             --prefix="${PREFIX}" \
             --system-libs \
             --no-qt-gui \
             --no-system-libarchive \
             --no-system-jsoncpp \
             --parallel=${CPU_COUNT} \
             -- \
             -DCMAKE_BUILD_TYPE:STRING=Release \
             -DCMAKE_FIND_ROOT_PATH="${PREFIX}" \
             -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
             -DCURSES_INCLUDE_PATH="${PREFIX}/include" \
             -DBUILD_CursesDialog=ON \
             -DCMake_HAVE_CXX_MAKE_UNIQUE:INTERNAL=FALSE \
             -DCMAKE_PREFIX_PATH="${PREFIX}" \
             -DCMAKE_CXX_STANDARD:STRING=17

make install -j${CPU_COUNT}

