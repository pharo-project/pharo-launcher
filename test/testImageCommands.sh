#!/usr/bin/env bash

./ensureShunitIsPresent.sh
processListCommand="./pharo-launcher.sh image processList"
launchCommand="./pharo-launcher.sh image launch PhLTestImage"
killAllCommand="./pharo-launcher.sh image kill --all"
killCommand="./pharo-launcher.sh image kill PhLTestImage"

oneTimeSetUp() {
	./createSampleImageCmd.sh
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
}

# Load shUnit2.
. ./shunit2/shunit2
