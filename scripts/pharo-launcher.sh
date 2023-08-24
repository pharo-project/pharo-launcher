#!/usr/bin/env bash


# some magic to find out the real location of this script dealing with symlinks
DIR=`readlink "$0"` || DIR="$0";
ROOT=`dirname "$DIR"`;
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
                                
# RUN THE VM and pass along all arguments as is ================================
if [ "$OS" = "linux" ]; then
    "$ROOT"/pharo-vm/pharo --headless "$ROOT"/shared/PharoLauncher.image clap launcher "$@"
elif [ "$OS" = "mac" ]; then 
    "$ROOT"/Pharo --headless "$ROOT"/../Resources/PharoLauncher.image clap launcher "$@"
fi
