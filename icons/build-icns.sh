#!/bin/sh

# $1 is the source PNG file to convert into ICNS
# $2 is the output folder and the ICNS file name
# ex: ./build-icns.sh pharo-launcher.png PharoLauncher.iconset

if (( $# != 2 )); then
    echo "Usage: $0 source-image icns-file-name"
    exit 1
fi
if [ -e "$2" ] ; then
    echo "output folder $2 already exists!"
    exit 1
fi

mkdir $2
sips -z   16   16 $1 --out $2/icon_16x16.png
sips -z   32   32 $1 --out $2/icon_16x16@2x.png
sips -z   32   32 $1 --out $2/icon_32x32.png
sips -z   64   64 $1 --out $2/icon_32x32@2x.png
sips -z  128  128 $1 --out $2/icon_128x128.png
sips -z  256  256 $1 --out $2/icon_128x128@2x.png
sips -z  256  256 $1 --out $2/icon_256x256.png
sips -z  512  512 $1 --out $2/icon_256x256@2x.png
sips -z  512  512 $1 --out $2/icon_512x512.png
sips -z 1024 1024 $1 --out $2/icon_512x512@2x.png
iconutil --convert icns $2
