#!/usr/bin/env bash

set -ex
# This script creates a .dmg out of an .app file. The resulting .dmg
# shows a nice pharo background and let the user drag&drop an
# application in /Applications.

# I can be run independently of the whole Pharo Launcher app building.
# e.g. VERSION=2b89478 APP_NAME=PharoLauncher build-dmg.sh

# The disk image is built by dmgbuild (https://github.com/dmgbuild/dmgbuild,
# `pip install dmgbuild`). It writes the window layout (.DS_Store) itself,
# so Finder is not scripted and no GUI session is needed.
# The layout is described in dmg-settings.json (node-appdmg format).

readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
readonly APP_NAME=${APP_NAME:-"Pharo"}
readonly VERSION=${VERSION:-"3.0.0"}
DMG_BACKGROUND_IMG=${DMG_BACKGROUND_IMG:-"background.png"}

readonly VOL_NAME="${APP_NAME} ${VERSION}"   # volume name will be "SuperCoolApp 1.0.0"
readonly DMG_FINAL="${VOL_NAME/ /_}.dmg"     # final DMG name will be "SuperCoolApp_1.0.0.dmg"
readonly SETTINGS_TEMPLATE="${SCRIPT_DIR}/dmg-settings.json"
readonly SETTINGS_FILE="./dmg-settings.json"

check_background_image_DPI_and_convert_it_if_not_72_by_72() {
    local _BACKGROUND_IMAGE_DPI_H=$(sips -g dpiHeight ${DMG_BACKGROUND_IMG} | grep -Eo '[0-9]+\.[0-9]+')
    local _BACKGROUND_IMAGE_DPI_W=$(sips -g dpiWidth ${DMG_BACKGROUND_IMG} | grep -Eo '[0-9]+\.[0-9]+')

    if [ $(echo " $_BACKGROUND_IMAGE_DPI_H != 72.0 " | bc) -eq 1 -o $(echo " $_BACKGROUND_IMAGE_DPI_W != 72.0 " | bc) -eq 1 ]; then
       echo "WARNING: The background image's DPI is not 72.  This will result in distorted backgrounds on Mac OS X 10.7+."
       echo "         I will convert it to 72 DPI for you."

       local _DMG_BACKGROUND_BASENAME="${DMG_BACKGROUND_IMG##*/}"
       local _DMG_BACKGROUND_TMP="${_DMG_BACKGROUND_BASENAME%.*}"_dpifix."${DMG_BACKGROUND_IMG##*.}"

       sips -s dpiWidth 72 -s dpiHeight 72 ${DMG_BACKGROUND_IMG} --out ${_DMG_BACKGROUND_TMP}

       DMG_BACKGROUND_IMG="${_DMG_BACKGROUND_TMP}"
    fi
}

clear_out_any_old_data() {
    rm -f "${DMG_FINAL}" "${SETTINGS_FILE}"
}

# The JSON title overrides the volume name given to dmgbuild, and its paths
# are resolved from the current directory: fill them in a copy of the template.
write_the_settings_file() {
    cp "${SETTINGS_TEMPLATE}" "${SETTINGS_FILE}"
    plutil -replace title -string "${VOL_NAME}" "${SETTINGS_FILE}"
    plutil -replace background -string "${DMG_BACKGROUND_IMG}" "${SETTINGS_FILE}"
    plutil -replace contents.0.path -string "${APP_NAME}.app" "${SETTINGS_FILE}"
}

build_the_disk_image() {
    dmgbuild -s "${SETTINGS_FILE}" "${VOL_NAME}" "${DMG_FINAL}"
}

clean_up() {
    rm -f "${SETTINGS_FILE}"
}

check_background_image_DPI_and_convert_it_if_not_72_by_72
clear_out_any_old_data
write_the_settings_file
build_the_disk_image
clean_up
echo 'Done.'

exit
