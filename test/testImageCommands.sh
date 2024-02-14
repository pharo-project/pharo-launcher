#!/usr/bin/env bash

# import functions that are shared across unit tests
source PharoLauncherCommonFunctions.sh

#ensure that Shell unit test library is installed
ensureShunitIsPresent

#setup sample image name and template name
SAMPLE_IMAGE="PhLTestImage"
SAMPLE_TEMPLATE="Pharo 10.0 - 64bit (stable)"
IMAGE_METADATA_FILE="meta-inf.ston"
SAMPLE_IMAGE_PATH="$HOME"/Pharo/images/$SAMPLE_IMAGE

# setup commands for sample image manipulation
createSampleImageCommand () {
    runLauncherScript image create $SAMPLE_IMAGE --no-launch --templateName "$SAMPLE_TEMPLATE"
    cp -f "$ROOT"/$IMAGE_METADATA_FILE $SAMPLE_IMAGE_PATH/$IMAGE_METADATA_FILE
}

launchSampleImageCommand () {
    runLauncherScript image launch --detached $SAMPLE_IMAGE
}

killSampleImageCommand () {
    runLauncherScript process kill $SAMPLE_IMAGE
}

deleteSampleImageCommand () { 
    runLauncherScript image delete --force $SAMPLE_IMAGE
}

processListCommand () {
    runLauncherScript process list
}

killAllCommand () {
    runLauncherScript image kill --all
}

updateVMforSampleImage () {
    runLauncherScript vm update 100-x64
}


oneTimeSetUp() {
    echo "Running oneTimeSetup..."
    echo "Preparing launcher script and image."
	prepareLauncherScriptAndImage
	echo "Setting up image template list."
	setupImageTemplateList
	echo "Updating VM for running sample image."
	updateVMforSampleImage
	echo "Creating sample image."
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
     kill $(pgrep -l -f $SAMPLE_IMAGE.image |  cut -d ' ' -f1)> /dev/null
     assertContainsPrinted "$result" "$SAMPLE_IMAGE"
 }

# Following unit test is disabled due to the fact that there are running concurrent builds on CI that might be killed accidentally by this test

# testLauncherKillAllCommandWithOneImageLaunchedShouldKillAll(){
# 	launchSampleImageCommand> /dev/null
# 	result=$(processListCommand)
# 	assertContainsPrinted "$result" "$SAMPLE_IMAGE"
# 	killAllCommand
# 	result=$(processListCommand)
# 	assertNotContainsPrinted "$result" "$SAMPLE_IMAGE"
# }

 testLauncherKillCommandWithOneImageLaunchedShouldKillIt(){
 	launchSampleImageCommand> /dev/null
 	result=$(processListCommand)
 	assertContainsPrinted "$result" "$SAMPLE_IMAGE"
 	killSampleImageCommand
 	result=$(processListCommand)
 	assertNotContainsPrinted "$result" "$SAMPLE_IMAGE"
 }

oneTimeTearDown() {
    #need this to suppress tearDown on script EXIT
    [[ "${_shunit_name_}" = 'EXIT' ]] && return 0

	echo "Running teardown..."
	echo "Killing sample image (if running)."
	kill $(pgrep -l -f $SAMPLE_IMAGE.image |  cut -d ' ' -f1)> /dev/null
	echo "Deleting sample image."
	deleteSampleImageCommand
	echo "Cleaning launcher script and image."
	cleanupLauncherScriptAndImage
	echo "Restoring original image template list."
	restoreOriginalImageTemplateList
}

# Load shUnit2.
. $SHUNIT
