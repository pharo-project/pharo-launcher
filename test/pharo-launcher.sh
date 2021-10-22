#!/usr/bin/env bash
 
# Using default VM path and image path of Pharo Launcher, depending on OS
OSNAME=$(uname -s)
case $OSNAME in
  Linux*)
    LAUNCHERDIR=/home/$USER/pharolauncher
    $(uname -s)=$LAUNCHERDIR/pharo-vm/pharo
    IMAGEPATH=$LAUNCHERDIR/shared/PharoLauncher.image
    ;;
  Darwin*)
    LAUNCHERDIR=/Applications/PharoLauncher.app/Contents
    VMPATH=$LAUNCHERDIR/MacOS/Pharo
    IMAGEPATH=$LAUNCHERDIR/Resources/PharoLauncher.image
    ;;
# TODO Windows
#  msys*)
#    ;;
  *)
    echo "Unsupported OS for Pharo Launcher: $OSNAME"
    exit 1
    ;;
esac
                                
$"$VMPATH" --headless "$IMAGEPATH" clap launcher "$@"

