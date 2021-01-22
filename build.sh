#!/bin/bash

set -e
set -x

curl -L -O https://github.com/llvm/llvm-project/releases/download/llvmorg-$version/llvm-$version.src.tar.xz
curl -L -O https://github.com/llvm/llvm-project/releases/download/llvmorg-$version/clang-$version.src.tar.xz
tar xf llvm-$version.src.tar.xz
tar xf clang-$version.src.tar.xz
mv clang-$version.src llvm-$version.src/tools/clang

mkdir build install
cd build
cmake ../llvm-$version.src -DCMAKE_INSTALL_PREFIX=$PWD/../install -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_ENABLE_LIBEDIT=OFF -DLLVM_ENABLE_ZLIB=OFF -DLLVM_ENABLE_ASSERTIONS=OFF
make install -j2 # tune this for how many cores you have
cd ..

mv install clang+llvm-$version-$triple
tar cfJv clang+llvm-$version-$triple.tar.xz clang+llvm-$version-$triple
