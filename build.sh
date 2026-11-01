#!/bin/bash
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

# 🚀 ULTIMATE FLAGS: हर उस एरर को इग्नोर करने के लिए जो 4.14 MTK में आती है
KCFLAGS_FIX="-Wno-error -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=return-type -Wno-error=macro-redefined -Wno-error=array-bounds -Wno-error=unused-variable -Wno-error=address-of-packed-member -Wno-error=frame-larger-than= -Wno-error=shift-op-parentheses -Wno-error=dangling-else -Wno-error=fortify-source -Wno-error=unused-but-set-variable -Wno-error=declaration-after-statement"

echo ">>> Generating Defconfig..."
make O=out ARCH=arm64 camellia_defconfig

echo ">>> Compiling Kernel..."
# -k (keep going) का मतलब है कि अगर कहीं फेल भी हो तो रुकेगा नहीं, सारी फाइलें कंपाइल करेगा
make -k -j$(nproc --all) O=out ARCH=arm64 \
  CC=clang \
  LLVM=1 LLVM_IAS=1 \
  KCFLAGS="$KCFLAGS_FIX"
