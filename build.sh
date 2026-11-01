#!/bin/bash
set -e
export PATH="$GITHUB_WORKSPACE/toolchain/clang/bin:$GITHUB_WORKSPACE/toolchain/gcc-64/bin:$GITHUB_WORKSPACE/toolchain/gcc-32/bin:$PATH"
export ARCH=arm64
export SUBARCH=arm64
export CC=clang
export LD=ld.lld
export AR=llvm-ar
export NM=llvm-nm
export OBJCOPY=llvm-objcopy
export OBJDUMP=llvm-objdump
export STRIP=llvm-strip
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-
KCFLAGS_FIX="-Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=return-type -Wno-error=macro-redefined -Wno-error=array-bounds  -Wno-error=unused-variable -Wno-error=address-of-packed-member"
echo ">>> Generating Defconfig..."
make O=out ARCH=arm64 camellia_defconfig
echo ">>> Compiling Kernel..."
make -k -j$(nproc --all) O=out ARCH=arm64 CC=clang LLVM=1 LLVM_IAS=1 KCFLAGS="$KCFLAGS_FIX"
