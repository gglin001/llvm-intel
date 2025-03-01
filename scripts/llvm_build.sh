#!/bin/bash

rm -f $PWD/llvm-dpcpp/llvm/CMakePresets.json
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-dpcpp/llvm/CMakePresets.json

pushd llvm-dpcpp

cmake --preset osx -S$PWD/llvm -B$PWD/build

# TODO: only build install-distribution ?

cmake --build $PWD/build --target all
# cmake --build $PWD/build --target install

popd

###############################################################################
