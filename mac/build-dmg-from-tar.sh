#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Default values
ARCH=""
VERSION=""
TAR_FILE=""

# Function to show usage
usage() {
    echo "Usage: $0 --arch <architecture> --version <version> <tar-file>"
    exit 1
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --arch)
            ARCH="$2"
            shift 2
            ;;
        --version)
            VERSION="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            if [[ -z "$TAR_FILE" ]]; then
                TAR_FILE="$1"
            else
                echo "Unexpected argument: $1"
                usage
            fi
            shift
            ;;
    esac
done

# Validate inputs
if [[ -z "$ARCH" || -z "$VERSION" || -z "$TAR_FILE" ]]; then
    echo "Error: Missing required arguments."
    usage
fi

if [[ ! -f "$TAR_FILE" ]]; then
    echo "Error: TAR file does not exist."
    exit 1
fi

move_pharo_launcher_app_to_the_current_directory() {
  find . -name PharoLauncher.app -print0 | xargs -0 -I{} mv {} .
}

clean_up() {
  echo "Cleaning up temporary files."
  rm -rf "$TMP_DIR"
}

TMP_DIR=$(mktemp -d)
tar -xf "$TAR_FILE" -C "$TMP_DIR"
pushd "$TMP_DIR"
move_pharo_launcher_app_to_the_current_directory
chmod +x PharoLauncher.app/Contents/MacOS/Pharo PharoLauncher.app/Contents/Resources/pharo-launcher || true
ARCHITECTURE=$ARCH VERSION=$VERSION APP_NAME=PharoLauncher "$SCRIPT_DIR"/build-dmg.sh
generated_dmg=$(echo *.dmg)
popd
mv "$TMP_DIR"/"$generated_dmg" "PharoLauncher-${VERSION}-${ARCH}.dmg"
generated_dmg=$(echo *.dmg)
md5 "$generated_dmg" > "$generated_dmg.md5sum"
echo "DMG created: $generated_dmg"
clean_up