#!/bin/sh

VERSION=${VERSION:-"5.0.0"}

cd pharo-build-scripts/windows-installer
mkdir Pharo-win
mv ../../Pharo Pharo-win/
NSIS/Bin/makensis.exe pharo-launcher-installer-builder.nsi
mv pharo-launcher-installer.exe ../../pharo-launcher-installer-"$VERSION".exe
