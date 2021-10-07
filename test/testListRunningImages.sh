#!/bin/sh 
# file: examples/testListRunnning2.sh
./ensureShunitIsPresent.sh
processListCommand="./pharo-launcher.sh image processList"
launchCommand="./pharo-launcher.sh image launch ./../shared/PharoLauncher.image"

testLauncherPsCommandWhenNoPharoImageRunningShouldReturnEmptyList(){
	echo $processListCommand
	result=$($processListCommand)
	echo $result
	assertNull "$result"
}

#oneTimeSetUp() {
#	$launchCommand >/dev/null
#}

testLauncherPsCommandWhenImageIsLaunchedShouldReturnOneImage(){
	$launchCommand >/dev/null
	result=$($processListCommand)
	assertNotNull "$result"
}

oneTimeTearDown() {
	kill $(pgrep -l -f PharoLauncher.image |  cut -d ' ' -f1) >/dev/null
	}

# Load shUnit2.
. ./shunit2/shunit2
