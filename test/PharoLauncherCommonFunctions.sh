#!/usr/bin/env bash

# some magic to find out the real location of this script dealing with symlinks
DIR=`readlink "$0"` || DIR="$0";
ROOT=`dirname "$DIR"`;

#setup pharo launcher and image name paths
PHL_SCRIPT="$ROOT"/pharo-launcher.sh
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

detectPharoLauncherImagePath() {
	# pharo-launcher.sh script used for testing is the one packaged in the distributed app
	# That's why we need to adapt paths to the ones used in production.

	# DETECT SYSTEM PROPERTIES ======================================================
	OS=`uname | tr "[:upper:]" "[:lower:]"`
	if [[ "{$OS}" = *darwin* ]]; then
		mkdir -p "$ROOT"/../Resources
		IMAGE="$ROOT"/../Resources/PharoLauncher.image
	elif [[ "{$OS}" = *linux* ]]; then
		mkdir -p "$ROOT"/shared
		IMAGE="$ROOT"/shared/PharoLauncher.image
	else
		echo "Unsupported OS";
		exit 1;
	fi
}

prepareLauncherScriptAndImage () {
	# ensure that launcher script and image are in needed directories for test evaluation (before packaging)
	pushd .. > /dev/null
	if [ ! -f "$PHL_SCRIPT" ] ; then
	    cp ./script/pharo-launcher.sh $PHL_SCRIPT
	fi
	detectPharoLauncherImagePath
	if [ ! -f "$IMAGE" ] ; then
	    cp PharoLauncher.image $IMAGE
	fi
	popd > /dev/null
}

cleanupLauncherScriptAndImage () {
	pushd .. > /dev/null
	rm -rf "$ROOT"/shared "$ROOT"/../Resources
	rm -f $PHL_SCRIPT
	popd > /dev/null
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
