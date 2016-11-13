#!/bin/bash

. ${DRISHTISDK}/bin/build-common.sh

DRISHTI_ASAN=0

if [ $DRISHTI_ASAN -gt 0 ]; then

    TOOLCHAIN=osx-10-11-sanitize-address
    DRISHTI_BUILD_SHARED_SDK=OFF
    DRISHTI_BUILD_ASAN_TEST=ON

else

    TOOLCHAIN=xcode-sections
    DRISHTI_BUILD_SHARED_SDK=ON
    DRISHTI_BUILD_ASAN_TEST=OFF

fi

EXTRA_ARGS=""
if [ $# -ge 1 ]; then
    EXTRA_ARGS="--reconfig"
#    EXTRA_ARGS="--clear"
fi

#DRISHTI_CONFIGURATION=Release
DRISHTI_CONFIGURATION=MinSizeRel
DRISHTI_BUILD_QT=OFF
DRISHTI_BUILD_OGLES_GPGPU=OFF
DRISHTI_USE_TEXT_ARCHIVES=OFF
DRISHTI_BUILD_C_INTERFACE=ON
DRISHTI_BUILD_WORLD=ON

rename_tab drishti ${TOOLCHAIN}

COMMAND=(
    "--verbose --fwd "
    "HUNTER_CONFIGURATION_TYPES=${DRISHTI_CONFIGURATION} "
    "${DRISHTI_BUILD_ARGS[*]} "
    "${DRISHTI_BUILD_HIDE[*]} "
    "DRISHTI_BUILD_QT=${DRISHTI_BUILD_QT} "
    "DRISHTI_BUILD_OGLES_GPGPU=${DRISHTI_BUILD_OGLES_GPGPU} "
    "DRISHTI_BUILD_MIN_SIZE=${DRISHTI_BUILD_MIN_SIZE} "
    "DRISHTI_USE_TEXT_ARCHIVES=${DRISHTI_USE_TEXT_ARCHIVES} "
    "DRISHTI_BUILD_C_INTERFACE=${DRISHTI_BUILD_C_INTERFACE} "
    "DRISHTI_BUILD_WORLD=${DRISHTI_BUILD_WORLD} "
    "DRISHTI_BUILD_SHARED_SDK=${DRISHTI_BUILD_SHARED_SDK} "
    "DRISHTI_BUILD_ASAN_TEST=${DRISHTI_BUILD_ASAN_TEST} "
    "--jobs 8 "
    "--open "
    "--install "
    "${EXTRA_ARGS} " " --test"
)

build.py --toolchain ${TOOLCHAIN} ${COMMAND[*]}


