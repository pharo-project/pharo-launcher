#!/usr/bin/env bash

# import functions that are shared across unit tests
source PharoLauncherCommonFunctions.sh

#ensure that Shell unit test library is installed
ensureShunitIsPresent

#setup sample image name and template name
SAMPLE_IMAGE="PhLTestImage"
SAMPLE_TEMPLATE="Pharo 10.0 - 64bit (stable)"

# setup commands for sample image manipulation
createSampleImageCommand () {
    runLauncherScript image create $SAMPLE_IMAGE "$SAMPLE_TEMPLATE"
}

launchSampleImageCommand () {
    runLauncherScript image launch $SAMPLE_IMAGE
}

killSampleImageCommand () {
    runLauncherScript image kill $SAMPLE_IMAGE
}

deleteSampleImageCommand () { 
    runLauncherScript image delete $SAMPLE_IMAGE
}

processListCommand () {
    runLauncherScript image processList
}

killAllCommand () {
    runLauncherScript image kill --all
}



oneTimeSetUp() {
	prepareLauncherScriptAndImage
	setupImageTemplateList
	createSampleImageCommand
}

testLauncherProcessListCommandWhenNoPharoImageRunningShouldReturnEmptyList(){
	result=$(processListCommand)
	#since VM prints some warnings, we need to check presence of image name from process list
	assertNotContainsPrinted "$result" "$SAMPLE_IMAGE"
}

testLauncherProcessListCommandWhenImageIsLaunchedShouldReturnOneImage(){
    launchSampleImageCommand> /dev/null
    result=$(processListCommand)
    kill $(pgrep -l -f $SAMPLE_IMAGE.image |  cut -d ' ' -f1) >/dev/null
    assertContainsPrinted "$result" "$SAMPLE_IMAGE"
	
}

testLauncherKillAllCommandWithOneImageLaunchedShouldKillAll(){
	launchSampleImageCommand> /dev/null
	result=$(processListCommand)
	assertContainsPrinted "$result" "$SAMPLE_IMAGE"
	killAllCommand
	result=$(processListCommand)
	assertNotContainsPrinted "$result" "$SAMPLE_IMAGE"
}

testLauncherKillCommandWithOneImageLaunchedShouldKillIt(){
	launchSampleImageCommand> /dev/null
	result=$(processListCommand)
	assertContainsPrinted "$result" "$SAMPLE_IMAGE"
	killSampleImageCommand
	result=$(processListCommand)
	assertNotContainsPrinted "$result" "$SAMPLE_IMAGE"
}

oneTimeTearDown() {
	echo "Calling teardown..."
	deleteSampleImageCommand
	cleanupLauncherScriptAndImage
	restoreOriginalImageTemplateList
}

# Load shUnit2.
. $SHUNIT
