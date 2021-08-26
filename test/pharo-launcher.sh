#!/usr/bin/env bash

# some magic to find out the real location of this script dealing with symlinks
DIR=`readlink "$0"` || DIR="$0";
ROOT=`dirname "$DIR"`;
DEFAULTLOCATION=$ROOT/..;
PHAROVM=/pharo-vm/pharo
PHAROLAUNCHER=PharoLauncher.image


if [ -z "$ARCHITECTURE" ] ; then
    ARCHITECTURE=32;
fi
                                
"$DEFAULTLOCATION""$PHAROVM" --nodisplay "$DEFAULTLOCATION"/"$PHAROLAUNCHER" clap launcher "$@"

