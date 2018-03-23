#!/bin/sh

VERSION=${VERSION:-"1.0.0"}

# NSIS is run in the directory where the NSI file stands
cp pharo-launcher.ico windows/
mkdir windows/Pharo-win
mv Pharo windows/Pharo-win/
pharo-build-scripts/windows-installer/NSIS/Bin/makensis.exe /DVERSION=$VERSION windows/pharo-launcher-installer-builder.nsi
mv windows/pharo-launcher-installer.exe pharo-launcher-installer-"$VERSION".exe
