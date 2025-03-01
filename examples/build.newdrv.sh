###############################################################################

# examples/vector-add.cpp
# from:
# sycl/test/native_cpu/vector-add.cpp

export PATH="$PWD/llvm-dpcpp/build/bin:$PATH"
export LD_LIBRARY_PATH="$PWD/llvm-dpcpp/build/lib:$LD_LIBRARY_PATH"

###############################################################################

DIR=examples/build.newdrv && mkdir -p $DIR
PPWD=$PWD && pushd $DIR
args=(
  -fsycl
  -fsycl-targets=spir64
  # -fsycl-targets=spirv64
  # -fsycl-targets=native_cpu
  #
  -fuse-ld=lld
  #
  # -isystem $PPWD/llvm-dpcpp/build-sycl/include
  # -L$PPWD/llvm-dpcpp/build-sycl/lib
  #
  # -fsycl-device-only
  -fno-sycl-use-footer
  #
  -O0
  # -O1
  # -O2
  # -O3
  #
  # -v
  -save-temps=obj
  # -fsycl-dump-device-code=.
  #
  # -g
  # -Xspirv-translator --spirv-debug-info-version=ocl-100
  # -Xspirv-translator -spirv-ext=-all
  #
  --offload-new-driver
  --offload-link
  #
  -o main
  $PPWD/examples/vector-add.cpp
)
clang++ "${args[@]}" 2>&1 | tee build.log
# SYCL_DEVICELIB_NO_FALLBACK=1 \
#   clang++ "${args[@]}" 2>&1 | tee build.log
popd

exit

###############################################################################

# need spirv-tools
#
DIR=examples/build.newdrv && mkdir -p $DIR
find $DIR/*.spv -print0 | xargs -0 -I{} spirv-dis {} -o {}asm

###############################################################################
