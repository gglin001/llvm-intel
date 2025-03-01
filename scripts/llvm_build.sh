#!/bin/bash

rm -f $PWD/llvm-dpcpp/llvm/CMakePresets.json
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-dpcpp/llvm/CMakePresets.json

###############################################################################

pushd llvm-dpcpp

cmake --preset linux -S$PWD/llvm -B$PWD/build

# TODO: only build install-distribution ?

cmake --build $PWD/build --target all
# cmake --build $PWD/build --target install

popd

###############################################################################

pushd llvm-dpcpp

cmake --preset sycl -S$PWD/llvm -B$PWD/build-sycl
# or
# cmake --preset sycl -S$PWD/llvm -B$PWD/build-sycl -DCMAKE_BUILD_TYPE=Debug

# cmake --build $PWD/build-sycl --target all
cmake --build $PWD/build-sycl --target libsycldevice
cmake --build $PWD/build-sycl --target libsycl.so
cmake --build $PWD/build-sycl --target libsycl-preview.so
cmake --build $PWD/build-sycl --target sycl-ls

find build-sycl/bin -name "sycl*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/bin/{} $PWD/build/bin/
find build-sycl/lib -name "libsycl*.o" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
find build-sycl/lib -name "libsycl*.so*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
find build-sycl/lib -name "libsycl*.a*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
find build-sycl/lib -name "libOpenCL*" -printf "%f\n" | xargs -d"\n" -I{} ln -s $PWD/build-sycl/lib/{} $PWD/build/lib/
ln -s $PWD/build-sycl/include/CL $PWD/build/include/
ln -s $PWD/build-sycl/include/sycl* $PWD/build/include/
ln -s $PWD/build-sycl/include/ur* $PWD/build/include/

popd

###############################################################################
