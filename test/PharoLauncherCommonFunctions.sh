#!/usr/bin/env bash

# some magic to find out the real location of this script dealing with symlinks
DIR=$(readlink "$0") || DIR="$0";
ROOT=$(dirname "$DIR");

#setup pharo launcher and image name paths
PHL_SCRIPT="$ROOT"/../scripts/pharo-launcher.sh
PHARO_LAUNCHER_IMAGE="$ROOT"/../PharoLauncher.image
PHARO_LAUNCHER_VM="$ROOT"/../pharo # pharo headless wrapper script, avoid to find the exe path that is different on Linux ans MacOs
SHUNIT="$ROOT"/shunit2/shunit2
SOURCES_LIST_PATH="$HOME"/Pharo/sources.list
SOURCES_LIST_BACKUP_PATH="${SOURCES_LIST_PATH}.original"

ensureShunitIsPresent () {
	#Check if shunit is present
	if test -f "$SHUNIT" ; then
		return $?
	fi

	# If shunit is not present we download it. 
	curl -L https://github.com/kward/shunit2/archive/refs/tags/v2.1.8.zip -o shunit.zip
	unzip shunit.zip -d shunit2
	mv shunit2/shunit2-*/* shunit2/
	rm -rf shunit2/shunit2-*
}

setupImageTemplateList () {
    #using own image template list file to have same templates that are used for testing
	if [ -f "$SOURCES_LIST_PATH" ] ; then
    	cp "$SOURCES_LIST_PATH" "$SOURCES_LIST_BACKUP_PATH"
	fi
    cp -f "$ROOT"/sources-for-tests.list "$SOURCES_LIST_PATH"
}

restoreOriginalImageTemplateList () {
    #restore original image template list file that was previously used
	if [ -f "$SOURCES_LIST_BACKUP_PATH" ] ; then
	    mv -f "$SOURCES_LIST_BACKUP_PATH" "$SOURCES_LIST_PATH"
	fi
}

runLauncherScript() {
	pushd .. > /dev/null
	$PHL_SCRIPT "$@"
	popd > /dev/null
}

assertContainsPrinted() {
    assertContains "Actual: \"$1\", expected: \"$2\". " "$1" "$2"
}

assertNotContainsPrinted() {
    assertNotContains "Actual: \"$1\", NOT expected: \"$2\". " "$1" "$2"
}
