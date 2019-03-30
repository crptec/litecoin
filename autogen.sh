#!/bin/sh
# Copyright (c) 2013-2016 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
set -e
srcdir="$(dirname $0)"
cd "$srcdir"
if [ -z ${LIBTOOLIZE} ] && GLIBTOOLIZE="`which glibtoolize 2>/dev/null`"; then
  LIBTOOLIZE="${GLIBTOOLIZE}"
  export LIBTOOLIZE
fi
which autoreconf >/dev/null || \
  (echo "configuration failed, please install autoconf first" && exit 1)
autoreconf --install --force --warnings=all

if [ -f /etc/centos-release ]; then
 echo LOL you run centos
fi

# check if last build file for cpp-ethereum exists, if so; then halt
if [ -f src/cpp-ethereum/test/CMakeFiles/testeth.dir/unittests/libweb3jsonrpc/jsonrpc.cpp.o ]; then
 exit
fi

# check cmake subversion
min_subversion=9
cmake_subver=$(cmake --version | head -n 1 | cut -d ' ' -f 3 | cut -d '.' -f 2)
if [ "$cmake_subver" -lt "$min_subversion" ]; then
   wget https://github.com/Kitware/CMake/releases/download/v3.14.0/cmake-3.14.0.tar.gz
   tar xvf cmake-3.14.0.tar.gz
   cd cmake-3.14.0
   ./configure
   make -j$(nproc) install
   ldconfig
   cd ..
   source  ~/.bashrc
fi

# proceed building cpp-ethereum
cd src/cpp-ethereum
git submodule update --init
../ethbridge/install-deps.sh
cmake .
make -j$(nproc)
