#!/usr/bin/env bash

set -ex
# This script creates a .dmg out of a DMG root made by make-dmg-root.sh.
# The resulting .dmg shows a nice pharo background and let the user drag&drop
# the application in /Applications.
#
# e.g. build-dmg.sh dmg-root PharoLauncher-3.4.1-arm64.dmg

# The disk image is built by dmgbuild (https://github.com/dmgbuild/dmgbuild,
# `pip install dmgbuild`). It writes the window layout (.DS_Store) itself,
# so Finder is not scripted and no GUI session is needed.
# The layout is described in the root's dmg-settings.json (node-appdmg format),
# whose paths are relative to the root.

if [[ "$#" -ne 2 ]]; then
    echo "Usage: $0 <dmg root dir> <dmg file>"
    exit 1
fi

readonly DMG_ROOT="$1"
readonly DMG_FINAL="$(pwd)/$2"

rm -f "${DMG_FINAL}"
# The volume name is the title of dmg-settings.json
pushd "${DMG_ROOT}"
dmgbuild -s dmg-settings.json "ignored" "${DMG_FINAL}"
popd
echo 'Done.'
