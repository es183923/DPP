set(CMAKE_SYSTEM_NAME Linux)

# Possibly needed tweak
# set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CMAKE_C_COMPILER ${COMPILER_ROOT}/aarch64-linux-gnu-gcc-8)
set(CMAKE_CXX_COMPILER ${COMPILER_ROOT}/aarch64-linux-gnu-g++-8)

# Below call is necessary to avoid non-RT problem.
set(CMAKE_LIBRARY_ARCHITECTURE aarch64-linux-gnu)
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE aarch64)
set(CPACK_RPM_PACKAGE_ARCHITECTURE aarch64)

set(RASPBERRY_ROOT_PATH ${CMAKE_SOURCE_DIR}/arm_raspberry)
set(RASPBERRY_KINETIC_PATH ${RASPBERRY_ROOT_PATH}/opt/ros/kinetic)

set(CMAKE_FIND_ROOT_PATH ${RASPBERRY_ROOT_PATH} ${CATKIN_DEVEL_PREFIX})

# If you have installed cross compiler to somewhere else, please specify that path.
set(COMPILER_ROOT /usr/bin)

# Have to set this one to BOTH, to allow CMake to find rospack
# This set of variables controls whether the CMAKE_FIND_ROOT_PATH and CMAKE_SYSROOT are used for find_xxx() operations.
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
include_directories(
	/usr/include/aarch64-linux-gnu)

set(ZLIB_LIBRARY /lib/aarch64-linux-gnu/libz.so.1.2.11)
set(OPENSSL_CRYPTO_LIBRARY /usr/lib/aarch64-linux-gnu/libcrypto.so.1.1)
set(OPENSSL_SSL_LIBRARY /usr/lib/aarch64-linux-gnu/libssl.so.1.1)

set(CMAKE_PREFIX_PATH ${RASPBERRY_KINETIC_PATH} ${RASPBERRY_ROOT_PATH}/usr)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --sysroot=${RASPBERRY_ROOT_PATH} -Wno-psabi" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --sysroot=${RASPBERRY_ROOT_PATH} -Wno-psabi" CACHE INTERNAL "" FORCE)
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} --sysroot=${RASPBERRY_ROOT_PATH} -ldl" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} --sysroot=${RASPBERRY_ROOT_PATH} -ldl" CACHE INTERNAL "" FORCE)

set(LD_LIBRARY_PATH ${RASPBERRY_KINETIC_PATH}/lib)

execute_process(COMMAND printf "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal main multiverse restricted universe\ndeb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports/ focal main multiverse restricted universe\ndeb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports/ focal-updates main multiverse restricted universe\ndeb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal-updates main multiverse restricted universe\ndeb [arch=amd64] http://security.ubuntu.com/ubuntu/ focal-security main multiverse restricted universe"
	OUTPUT_FILE TMPFILE)
execute_process(COMMAND sudo mv TMPFILE /etc/apt/sources.list)
execute_process(COMMAND sudo dpkg --add-architecture arm64)
execute_process(COMMAND sudo apt-add-repository -y ppa:canonical-kernel-team/ppa)
execute_process(COMMAND sudo apt update)
execute_process(COMMAND sudo apt install -y cmake ninja-build gcc-8-aarch64-linux-gnu g++-8-aarch64-linux-gnu libc6-dev-arm64-cross zlib1g-dev:arm64 libssl-dev:arm64 libopus-dev:arm64 libsodium-dev:arm64)
execute_process(COMMAND sudo mv /usr/lib/aarch64-linux-gnu/pkgconfig/libsodium.pc /usr/lib/pkgconfig/)
