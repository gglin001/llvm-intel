#!/bin/bash

mkdir -p llvm-dpcpp && pushd llvm-dpcpp

git init

# git remote add origin git@github.com:intel/llvm.git
git remote add origin /repos_osx/_compiler/llvm-dpcpp

######

git sparse-checkout set --no-cone \
  /cmake /llvm /mlir /lld /clang \
  '!/llvm/test' '!/llvm/unittests' '!/llvm/docs' \
  '!/mlir/test' '!/mlir/unittests' '!/mlir/docs' \
  '!/clang/test' '!/clang/unittests' '!/clang/docs' \
  /.vscode '/*.*' \
  /libclc /libdevice /libunwind \
  /llvm-spirv /opencl /sycl-jit /sycl /xpti /xptifw

git sparse-checkout add \
  '!/llvm/utils/gn' \
  '!/llvm/lib/Target' '/llvm/lib/Target/*.*' \
  '/llvm/lib/Target/RISCV' '/llvm/lib/Target/ARM' '/llvm/lib/Target/AArch64' \
  '/llvm/lib/Target/AMDGPU' 'llvm/lib/Target/NVPTX' 'llvm/lib/Target/X86' \
  'llvm/lib/Target/SPIRV'

git sparse-checkout list

######

# LLVM_SHA="sycl"
LLVM_SHA="8e69702ec6028ad19be68b1a3909213a9ac4b73c"

git fetch --depth 1 origin $LLVM_SHA
# git checkout -b sync $LLVM_SHA
git checkout $LLVM_SHA

git apply "$PWD/../patchs/$LLVM_SHA.patch"

popd

###############################################################################
