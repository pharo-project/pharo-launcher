#!/bin/sh

VERSION=${VERSION:-"1.0.0"}

ADVINST=${ADVINST:-"C:\Program Files (x86)\Caphyon\Advanced Installer 14.7\bin\x86\advinst.exe"}
ADVINST_PROJECT=pharo-launcher.aip
ADVINST_COMMAND_FILE=pharo-launcher.aic

PHARO_WIN_DIR="Pharo-win\Pharo"
OUT_DIR="build-aic"

# Advanced Installer working directory is the directory where the AIP file stands
cp icons/pharo-launcher.ico windows/
mkdir windows/Pharo-win
mv Pharo windows/Pharo-win/

# $ADVINST /newproject $ADVINST_PROJECT -lang en -overwrite
$ADVINST /execute $ADVINST_PROJECT $ADVINST_COMMAND_FILE

# mv windows/pharo-launcher-installer.exe pharo-launcher-installer-"$VERSION".exe
