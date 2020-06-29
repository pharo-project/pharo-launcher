#!/usr/bin/env bash

set -ex
# This script creats a .dmg out of an .app file. The resulting .dmg
# shows a nice pharo background and let the user drag&drop an
# application in /Applications.

# This script is taken from Andy Maloney
# http://asmaloney.com/2013/07/howto/packaging-a-mac-os-x-application-using-a-dmg/
# https://gist.github.com/asmaloney/55d96a8c3558b2f92cb3

# At some point, I could replace this script with https://github.com/LinusU/node-appdmg
APP_NAME=${APP_NAME:-"Pharo"}
VERSION=${VERSION:-"3.0.0"}
DMG_BACKGROUND_IMG=${DMG_BACKGROUND_IMG:-"background.png"}

# Indicate the vertical pixel where the icons (Pharo and Applications)
# will be positioned
ICON_VPOSITION=${ICON_VPOSITION:-168}

VOL_NAME="${APP_NAME} ${VERSION}"   # volume name will be "SuperCoolApp 1.0.0"
DMG_TMP="${VOL_NAME}-temp.dmg"
DMG_FINAL="${VOL_NAME/ /_}.dmg"         # final DMG name will be "SuperCoolApp_1.0.0.dmg"
STAGING_DIR="./Install"             # we copy all our stuff into this dir

# Check the background image DPI and convert it if it isn't 72x72
_BACKGROUND_IMAGE_DPI_H=`sips -g dpiHeight ${DMG_BACKGROUND_IMG} | grep -Eo '[0-9]+\.[0-9]+'`
_BACKGROUND_IMAGE_DPI_W=`sips -g dpiWidth ${DMG_BACKGROUND_IMG} | grep -Eo '[0-9]+\.[0-9]+'`

if [ $(echo " $_BACKGROUND_IMAGE_DPI_H != 72.0 " | bc) -eq 1 -o $(echo " $_BACKGROUND_IMAGE_DPI_W != 72.0 " | bc) -eq 1 ]; then
   echo "WARNING: The background image's DPI is not 72.  This will result in distorted backgrounds on Mac OS X 10.7+."
   echo "         I will convert it to 72 DPI for you."
   
   _DMG_BACKGROUND_TMP="${DMG_BACKGROUND_IMG%.*}"_dpifix."${DMG_BACKGROUND_IMG##*.}"

   sips -s dpiWidth 72 -s dpiHeight 72 ${DMG_BACKGROUND_IMG} --out ${_DMG_BACKGROUND_TMP}
   
   DMG_BACKGROUND_IMG="${_DMG_BACKGROUND_TMP}"
fi

# clear out any old data
rm -rf "${STAGING_DIR}" "${DMG_TMP}" "${DMG_FINAL}"

# copy over the stuff we want in the final disk image to our staging dir
mkdir -p "${STAGING_DIR}"
cp -rpf "${APP_NAME}.app" "${STAGING_DIR}"
# ... cp anything else you want in the DMG - documentation, etc.


# figure out how big our DMG needs to be
#  assumes our contents are at least 1M!
SIZE=`du -sh "${STAGING_DIR}" | sed 's/\([0-9\.]*\)M\(.*\)/\1/'` 
SIZE=`echo "${SIZE} + 2.0" | bc | awk '{print int($1+0.5)}'`

if [ $? -ne 0 ]; then
   echo "Error: Cannot compute size of staging dir"
   exit
fi

# Sign the app
function sign_mac_version() {
  # This function expects that following environment variables are available:
  # - PHARO_CERT_PASSWORD
  # - PHARO_SIGN_IDENTITY
  local keychain_name=macos-ci-build.keychain
  local keychain_password=ci
  local app_dir=$1
  local cert_pass=${PHARO_CERT_PASSWORD}
  local pharo_sign_password=${PHARO_CERT_PASSWORD}
  local sign_identity=${PHARO_SIGN_IDENTITY}

  # Get and Uncompress certificates
  local deploy_dir="./deploy"
  wget --quiet --directory-prefix="${deploy_dir}" https://github.com/OpenSmalltalk/opensmalltalk-vm/raw/Cog/deploy/pharo/pharo.cer.enc
  wget --quiet --directory-prefix="${deploy_dir}" https://github.com/OpenSmalltalk/opensmalltalk-vm/raw/Cog/deploy/pharo/pharo.p12.enc
  local path_cer="${deploy_dir}/pharo.cer"
  local path_p12="${deploy_dir}/pharo.p12"
  openssl aes-256-cbc -k "${pharo_sign_password}" -in "${path_cer}.enc" -out "${path_cer}" -d
  openssl aes-256-cbc -k "${pharo_sign_password}" -in "${path_p12}.enc" -out "${path_p12}" -d

  echo "Signing app bundle..."
  # Set up keychain
  security delete-keychain "${keychain_name}" || true
  security create-keychain -p ${keychain_password} "${keychain_name}"
  security default-keychain -s "${keychain_name}"
  security unlock-keychain -p ${keychain_password} "${keychain_name}"
  security set-keychain-settings -t 3600 -u "${keychain_name}"
  security import "${path_cer}" -k ~/Library/Keychains/"${keychain_name}" -T /usr/bin/codesign
  security import "${path_p12}" -k ~/Library/Keychains/"${keychain_name}" -P "${cert_pass}" -T /usr/bin/codesign
  # Set ACL on keychain. To avoid to get codesign to yield an errSecInternalComponent you need to get the partition list (ACLs) correct.
  # See https://code-examples.net/en/q/1344e6a
  security set-key-partition-list -S apple-tool:,apple: -s -k ${keychain_password} "${keychain_name}"
  # debug
  echo ${sign_identity} >> "id.txt"
  # Invoke codesign
  if [[ -d "${app_dir}/Contents/MacOS/Plugins" ]]; then # Pharo.app does not (yet) have its plugins in Resources dir
    codesign -s "${sign_identity}" --keychain "${keychain_name}" --force --deep "${app_dir}/Contents/MacOS/Plugins/"*
  fi
  codesign -s "${sign_identity}"  --keychain "${keychain_name}" --force --deep "${app_dir}"
  # Remove sensitive files again
  rm -rf "${path_cer}" "${path_p12}"
  security delete-keychain "${keychain_name}"
}

if [ "$SHOULD_SIGN" = true ] ; then
  sign_mac_version "${STAGING_DIR}"/"${APP_NAME}.app"
fi

# create the temp DMG file
hdiutil create -srcfolder "${STAGING_DIR}" -volname "${VOL_NAME}" -fs HFS+ \
      -fsargs "-c c=64,a=16,e=16" -format UDRW -size ${SIZE}M "${DMG_TMP}"

echo "Created DMG: ${DMG_TMP}"

# mount it and save the device
DEVICE=$(hdiutil attach -readwrite -noverify "${DMG_TMP}" | \
         egrep '^/dev/' | sed 1q | awk '{print $1}')

sleep 2

# add a link to the Applications dir
echo "Add link to /Applications"
pushd /Volumes/"${VOL_NAME}"
pwd
ls -la
ln -sf /Applications
popd

# add a background image
mkdir -p /Volumes/"${VOL_NAME}"/.background
cp "${DMG_BACKGROUND_IMG}" /Volumes/"${VOL_NAME}"/.background/

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

# unmount it
hdiutil detach "${DEVICE}"

# now make the final image a compressed disk image
echo "Creating compressed image"
hdiutil convert "${DMG_TMP}" -format UDZO -imagekey zlib-level=9 -o "${DMG_FINAL}"

# clean up
rm -rf "${DMG_TMP}"
rm -rf "${STAGING_DIR}"

echo 'Done.'

exit
