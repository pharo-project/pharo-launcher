#! /bin/sh
# file: examples/testKillImage.sh

./ensureShunitIsPresent.sh

launchCommand="./pharo-launcher.sh image launch ./../shared/PharoLauncher.image"
killCommand="./pharo-launcher.sh image kill --all"
processListCommand="./pharo-launcher.sh image ps"

oneTimeSetUp() {
	$launchCommand >/dev/null
}


testLauncherKillCommandWithOneImageLaunchedShouldKillIt(){
	result=$($processListCommand)
	assertNotNull "$result"
	$killCommand
	result=$($processListCommand)
	assertNull "$result"
}

. ./shunit2/shunit2
