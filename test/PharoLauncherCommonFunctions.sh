#!/usr/bin/env bash

#setup pharo launcher and image name paths
PHL_SCRIPT="./pharo-launcher.sh"
IMAGE=./shared/PharoLauncher.image

ensureShunitIsPresent () {
	#Check if shunit is present
	SHUNIT=./shunit2/shunit2
	if test -f "$SHUNIT" ; then
		return $?
	fi

	# If shunit is not present we download it. 
	curl -L https://github.com/kward/shunit2/archive/refs/tags/v2.1.8.zip -o shunit.zip
	unzip shunit.zip -d shunit2
	mv shunit2/shunit2-*/* shunit2/
	rm -rf shunit2/shunit2-*
}



prepareLauncherScriptAndImage () {
	# ensure that launcher script and image is in needed directories for test evaluation (before packaging)
	pushd .. > /dev/null
	if [ ! -f "$PHL_SCRIPT" ] ; then
	    cp ./script/pharo-launcher.sh $PHL_SCRIPT
	fi
	if [ ! -f "$IMAGE" ] ; then
		mkdir -p shared
	    cp PharoLauncher.image $IMAGE
	fi
	popd > /dev/null
}

cleanupLauncherScriptAndImage () {
	pushd .. > /dev/null
	rm -rf ./shared
	rm -f $PHL_SCRIPT
	popd > /dev/null
}

runLauncherScript() {
	pushd .. > /dev/null
	$PHL_SCRIPT $@
	popd > /dev/null
}

assertContainsPrinted() {
    assertContains "Actual: \"$1\", expected: \"$2\". " "$1" "$2"
}

assertNotContainsPrinted() {
    assertNotContains "Actual: \"$1\", NOT expected: \"$2\". " "$1" "$2"
}
