#!/usr/bin/env bash

set -ex
# This script creates a .dmg out of an .app file. The resulting .dmg
# shows a nice pharo background and let the user drag&drop an
# application in /Applications.

# I can be run independently of the whole Pharo Launcher app building.
# e.g. VERSION=2b89478 APP_NAME=PharoLauncher build-dmg.sh

# This script is taken from Andy Maloney
# http://asmaloney.com/2013/07/howto/packaging-a-mac-os-x-application-using-a-dmg/
# https://gist.github.com/asmaloney/55d96a8c3558b2f92cb3

# At some point, I could replace this script with https://github.com/LinusU/node-appdmg
readonly APP_NAME=${APP_NAME:-"Pharo"}
readonly VERSION=${VERSION:-"3.0.0"}
DMG_BACKGROUND_IMG=${DMG_BACKGROUND_IMG:-"mac-installer-background.png"}

# Indicate the vertical pixel where the icons (Pharo and Applications)
# will be positioned
readonly ICON_VPOSITION=${ICON_VPOSITION:-168}

readonly VOL_NAME="${APP_NAME} ${VERSION}"   # volume name will be "SuperCoolApp 1.0.0"
readonly DMG_TMP="${VOL_NAME}-temp.dmg"
readonly DMG_FINAL="${VOL_NAME/ /_}.dmg"         # final DMG name will be "SuperCoolApp_1.0.0.dmg"
readonly STAGING_DIR="./Install"             # we copy all our stuff into this dir

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
    rm -rf "${STAGING_DIR}" "${DMG_TMP}" "${DMG_FINAL}"
}

copy_over_the_stuff_we_want_in_the_final_disk_image_to_our_staging_dir() {
    mkdir -p "${STAGING_DIR}"
    cp -rpf "${APP_NAME}.app" "${STAGING_DIR}"
    # ... cp anything else you want in the DMG - documentation, etc.
}

compute_dmg_size() {
    # figure out how big our DMG needs to be
    #  assumes our contents are at least 1M!
    SIZE=`du -sh "${STAGING_DIR}" | sed 's/\([0-9\.]*\)M\(.*\)/\1/'`
    SIZE=`echo "${SIZE} + 2.0" | bc | awk '{print int($1+0.5)}'`

    if [ $? -ne 0 ]; then
       echo "Error: Cannot compute size of staging dir"
       exit
    fi
}

create_the_temp_DMG_file() {
    hdiutil create -srcfolder "${STAGING_DIR}" -volname "${VOL_NAME}" -fs HFS+ \
          -fsargs "-c c=64,a=16,e=16" -format UDRW -size ${SIZE}M "${DMG_TMP}"

    echo "Created DMG: ${DMG_TMP}"
}

mount_temp_DMG_and_save_the_device() {
    DEVICE=$(hdiutil attach -readwrite -noverify "${DMG_TMP}" | \
             egrep '^/dev/' | sed 1q | awk '{print $1}')

    sleep 2
}

add_a_link_to_the_Applications_dir() {
    echo "Add link to /Applications"
    pushd /Volumes/"${VOL_NAME}"
    pwd
    ls -la
    ln -sf /Applications
    popd
}

add_a_background_image() {
    mkdir -p /Volumes/"${VOL_NAME}"/.background
    cp "${DMG_BACKGROUND_IMG}" /Volumes/"${VOL_NAME}"/.background/

    # If the execution of the following script fails with a timeout,
    # ensure Apple TCC mechanism does not ask for a permission like:
    # “sshd-keygen-wrapper“ wants access to control “Finder“. If os,
    # allow the ssh to control Finder and the script will run fine.
    # ps: the script is run through SSH in the CI pipeline.

    # tell the Finder to resize the window, set the background,
    #  change the icon size, place the icons in the right position, etc.
    echo '
       tell application "Finder"
         tell disk "'${VOL_NAME}'"
               open
               set current view of container window to icon view
               set toolbar visible of container window to false
               set statusbar visible of container window to false
               set the bounds of container window to {400, 100, 920, 440}
               set viewOptions to the icon view options of container window
               set arrangement of viewOptions to not arranged
               set icon size of viewOptions to 72
               set background picture of viewOptions to file ".background:'${DMG_BACKGROUND_IMG}'"
               set position of item "'${APP_NAME}'.app" of container window to {160, '${ICON_VPOSITION}'}
               set position of item "Applications" of container window to {360, '${ICON_VPOSITION}'}
               close
               open
               update without registering applications
               delay 2
         end tell
       end tell
    ' | osascript

    sync
}

unmount_device() {
    hdiutil detach "${DEVICE}"
}

make_the_final_image_a_compressed_disk_image() {
    echo "Creating compressed image"
    hdiutil convert "${DMG_TMP}" -format UDZO -imagekey zlib-level=9 -o "${DMG_FINAL}"
}

clean_up() {
    rm -rf "${DMG_TMP}"
    rm -rf "${STAGING_DIR}"
}

check_background_image_DPI_and_convert_it_if_not_72_by_72
clear_out_any_old_data
copy_over_the_stuff_we_want_in_the_final_disk_image_to_our_staging_dir
compute_dmg_size
create_the_temp_DMG_file
mount_temp_DMG_and_save_the_device
add_a_link_to_the_Applications_dir
add_a_background_image
unmount_device
make_the_final_image_a_compressed_disk_image
clean_up
echo 'Done.'

exit
