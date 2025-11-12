#!/usr/bin/env bash

# some magic to find out the real location of this script dealing with symlinks
DIR=`readlink "$0"` || DIR="$0";
# disable parameter expansion to forward all arguments unprocessed to the VM
set -f

# DETECT SYSTEM PROPERTIES ======================================================
TMP_OS=`uname | tr "[:upper:]" "[:lower:]"`
if [[ "{$TMP_OS}" = *darwin* ]]; then
    OS="mac";
elif [[ "{$TMP_OS}" = *linux* ]]; then
    OS="linux";
elif [[ "{$TMP_OS}" = *win* ]]; then
    OS="win";
elif [[ "{$TMP_OS}" = *mingw* ]]; then
    OS="win";
elif [[ "{$TMP_OS}" = *msys* ]]; then
    OS="win";
else
    echo "Unsupported OS";
    exit 1;
fi

if [ -z "$ARCHITECTURE" ] ; then
    ARCHITECTURE=32;
fi

# SET IMAGE AND VM TO USE ======================================================
# : "${VARIABLE:=DEFAULT_VALUE}" assigns DEFAULT_VALUE to VARIABLE if not defined.
# It allow override of Pharo Launcher VM and image (ex: local testing)
if [ "$OS" = "linux" ]; then
    ROOT=$(dirname "$DIR");
    : "${PHARO_LAUNCHER_IMAGE:="$ROOT/shared/PharoLauncher.image"}"
    : "${PHARO_LAUNCHER_VM:="$ROOT/pharo-vm/pharo"}"
elif [ "$OS" = "mac" ]; then 
    ROOT=$(dirname "$(dirname "$DIR")");
    : "${PHARO_LAUNCHER_IMAGE:="$ROOT/Resources/PharoLauncher.image"}"
    : "${PHARO_LAUNCHER_VM:="$ROOT/MacOs/pharo"}"
fi
                                
# RUN THE VM and pass along all arguments as is ================================
"$PHARO_LAUNCHER_VM" --headless "$PHARO_LAUNCHER_IMAGE" --no-default-preferences clap launcher "$@"
