#!/usr/bin/env bash

# some magic to find out the real location of this script dealing with symlinks
DIR=$(readlink "$0") || DIR="$0";
ROOT=$(realpath "$(dirname "$DIR")");
export ROOT

#setup pharo launcher and image name paths
PHL_SCRIPT="$ROOT"/../scripts/pharo-launcher.sh
# PHARO_LAUNCHER_IMAGE="$ROOT"/../PharoLauncher.image
PHARO_LAUNCHER_IMAGE="/Users/demarey/Documents/Pharo/images/Pharo 12.0 - launcher dev/Pharo 12.0 - launcher dev.image"
export PHARO_LAUNCHER_IMAGE
PHARO_LAUNCHER_VM="$ROOT"/../pharo # pharo headless wrapper script, avoid to find the exe path that is different on Linux ans MacOs
export PHARO_LAUNCHER_VM
PHL_TEST_CONFIG_TEMPLATE="$ROOT/phl-test-config.template"
PHL_TEST_CONFIG="$ROOT/phl-test-config.ston"

SHUNIT="$ROOT"/shunit2/shunit2

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

setUpLauncherTestConfiguration () {
	sed "s/PHL_CLI_TEST_DIR/$ROOT/g" "$PHL_TEST_CONFIG_TEMPLATE" > "$PHL_TEST_CONFIG"
}

setupImageTemplateList () {
    #using own image template list file to have same templates that are used for testing
	mkdir -p "$ROOT"/Pharo
    cp -f "$ROOT"/sources-for-tests.list "$ROOT"/Pharo/sources.list
}

runLauncherScript() {
	pushd .. > /dev/null
	$PHL_SCRIPT --configuration "$PHL_TEST_CONFIG" "$@"
	popd > /dev/null
}

assertContainsPrinted() {
    assertContains "Actual: \"$1\", expected: \"$2\". " "$1" "$2"
}

assertNotContainsPrinted() {
    assertNotContains "Actual: \"$1\", NOT expected: \"$2\". " "$1" "$2"
}
