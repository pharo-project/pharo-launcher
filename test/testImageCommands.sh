#!/usr/bin/env bash

./ensureShunitIsPresent.sh

#setup pharo launcher and image name paths
PHLSCRIPT=./pharo-launcher.sh
IMAGE=./shared/PharoLauncher.image

# setup commands for image manipulation
processListCommand="runLauncherScript image processList"
launchCommand="runLauncherScript image launch PhLTestImage"
killAllCommand="runLauncherScript image kill --all"
killCommand="runLauncherScript image kill PhLTestImage"

oneTimeSetUp() {
	./createSampleImageCmd.sh
	prepareLauncherScriptAndImage
}

runLauncherScript() {
	pushd ..
	$PHLSCRIPT $@
	popd
}

prepareLauncherScriptAndImage () {
	# ensure that launcher script and image is in needed directories for test evaluation (before packaging)
	pushd ..
	if [ ! -f "$PHLSCRIPT" ] ; then
	    cp ./script/pharo-launcher.sh $PHLSCRIPT
	fi
	if [ ! -f "$IMAGE" ] ; then
		mkdir -p shared
	    cp PharoLauncher.image $IMAGE
	fi
	popd
}

cleanupLauncherScriptAndImage () {
	pushd ..
	rm -rf ./shared
	rm -f $PHLSCRIPT
	popd
}

testLauncherProcessListCommandWhenNoPharoImageRunningShouldReturnEmptyList(){
	result=$($processListCommand)
	assertNull "$result"
}

testLauncherProcessListCommandWhenImageIsLaunchedShouldReturnOneImage(){
	$launchCommand >/dev/null
	result=$($processListCommand)
	kill $(pgrep -l -f PhLTestImage.image |  cut -d ' ' -f1) >/dev/null
    assertNotNull "$result"
}

testLauncherKillAllCommandWithOneImageLaunchedShouldKillAll(){
	$launchCommand >/dev/null
	result=$($processListCommand)
	assertNotNull "$result"
	$killAllCommand
	result=$($processListCommand)
	assertNull "$result"
}

testLauncherKillCommandWithOneImageLaunchedShouldKillIt(){
	$launchCommand >/dev/null
	result=$($processListCommand)
	assertNotNull "$result"
	$killCommand
	result=$($processListCommand)
	assertNull "$result"
}

oneTimeTearDown() {
	./deleteSampleImageCmd.sh
	cleanupLauncherScriptAndImage
}

# Load shUnit2.
. ./shunit2/shunit2
