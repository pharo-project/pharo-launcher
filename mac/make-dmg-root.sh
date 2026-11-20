#!/usr/bin/env bash

set -ex
# This script assembles the root of the Pharo Launcher disk image: the folder whose
# content becomes the content of the .dmg.
# It holds the app, the link to /Applications, the background image and the
# dmg-settings.json describing the window layout (node-appdmg format).
# The paths in dmg-settings.json are relative to this folder: build the DMG from it with
#   cd <root> && dmgbuild -s dmg-settings.json <volume name> <dmg file>
# The signed DMG is built from the same folder.
#
# e.g. make-dmg-root.sh --app PharoLauncher.app --version 3.4.1-arm64 --output dmg-root

readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
readonly BACKGROUND_IMG="installer-background.png"
readonly SETTINGS_FILE="dmg-settings.json"

APP=""
VERSION=""
OUTPUT_DIR=""

usage() {
    echo "Usage: $0 --app <app bundle> --version <version> --output <dmg root dir>"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --app) APP="$2"; shift 2 ;;
        --version) VERSION="$2"; shift 2 ;;
        --output) OUTPUT_DIR="$2"; shift 2 ;;
        *) usage ;;
    esac
done

if [[ -z "$APP" || -z "$VERSION" || -z "$OUTPUT_DIR" ]]; then
    usage
fi
if [[ ! -d "$APP" ]]; then
    echo "Error: $APP is not an app bundle."
    exit 1
fi
if [[ -e "$OUTPUT_DIR" ]]; then
    echo "Error: $OUTPUT_DIR already exists."
    exit 1
fi

readonly APP_NAME=$(basename "$APP" .app)

# dmgbuild displays the background at its DPI: it must be 72 DPI to fill the window.
check_background_image_is_72_DPI() {
    if ! command -v sips > /dev/null; then
        return
    fi
    local dpi
    dpi=$(sips -g dpiWidth -g dpiHeight "$SCRIPT_DIR/$BACKGROUND_IMG" | grep -Eo '[0-9]+\.[0-9]+' | sort -u)
    if [[ "$dpi" != "72.000" ]]; then
        echo "Error: $BACKGROUND_IMG must be 72 DPI, not $dpi."
        exit 1
    fi
}

check_background_image_is_72_DPI
mkdir -p "$OUTPUT_DIR"
cp -a "$APP" "$OUTPUT_DIR/"
ln -s /Applications "$OUTPUT_DIR/Applications"
cp "$SCRIPT_DIR/$BACKGROUND_IMG" "$OUTPUT_DIR/"
cp "$SCRIPT_DIR/$SETTINGS_FILE" "$OUTPUT_DIR/"
plutil -replace title -string "${APP_NAME} ${VERSION}" "$OUTPUT_DIR/$SETTINGS_FILE"
plutil -replace contents.0.path -string "${APP_NAME}.app" "$OUTPUT_DIR/$SETTINGS_FILE"
echo "DMG root created: $OUTPUT_DIR"
