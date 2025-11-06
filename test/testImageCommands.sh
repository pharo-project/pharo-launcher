#!/usr/bin/env bash

# import functions that are shared across unit tests
source PharoLauncherCommonFunctions.sh

#ensure that Shell unit test library is installed
ensureShunitIsPresent

#setup sample image name and template name
TEST_IMAGE="PhLTestImage"
TEST_TEMPLATE="Pharo 10.0 - 64bit (stable)"
IMAGE_METADATA_FILE="meta-inf.ston"
TEST_IMAGE_PATH="$ROOT"/Pharo/images/$TEST_IMAGE

# setup commands for sample image manipulation
createTestImageCommand () {
    runLauncherScript image create $TEST_IMAGE --no-launch --templateName "$TEST_TEMPLATE"
    cp -f "$ROOT"/$IMAGE_METADATA_FILE $TEST_IMAGE_PATH/$IMAGE_METADATA_FILE
}

launchTestImageCommand () {
    runLauncherScript image launch --detached $TEST_IMAGE
}

killTestImageCommand () {
    runLauncherScript process kill $TEST_IMAGE
}

deleteTestImageCommand () { 
    runLauncherScript image delete --force $TEST_IMAGE
}

processListCommand () {
    runLauncherScript process list
}

killAllCommand () {
    runLauncherScript image kill --all
}

updateVMforTestImage () {
    runLauncherScript vm update 100-x64
}


oneTimeSetUp() {
    echo "Running oneTimeSetup..."
	echo "Setting up image template list."
	setupImageTemplateList
	echo "Updating VM for running Test image."
	updateVMforTestImage
	echo "Creating Test image."
	createTestImageCommand
}


testLauncherProcessListCommandWhenNoPharoImageRunningShouldReturnEmptyList(){
	result=$(processListCommand)
	#since VM prints some warnings, we need to check presence of image name from process list
	assertNotContainsPrinted "$result" "$TEST_IMAGE"
}

testLauncherProcessListCommandWhenImageIsLaunchedShouldReturnOneImage(){
    launchTestImageCommand > /dev/null
    result=$(processListCommand)
    kill $(pgrep -l -f $TEST_IMAGE.image |  cut -d ' ' -f1)> /dev/null
    assertContainsPrinted "$result" "$TEST_IMAGE"
}

# Following unit test is disabled due to the fact that there are running concurrent builds on CI that might be killed accidentally by this test

# testLauncherKillAllCommandWithOneImageLaunchedShouldKillAll(){
# 	launchTestImageCommand > /dev/null
# 	result=$(processListCommand)
# 	assertContainsPrinted "$result" "$TEST_IMAGE"
# 	killAllCommand
# 	result=$(processListCommand)
# 	assertNotContainsPrinted "$result" "$TEST_IMAGE"
# }

 testLauncherKillCommandWithOneImageLaunchedShouldKillIt(){
 	launchTestImageCommand > /dev/null
 	result=$(processListCommand)
 	assertContainsPrinted "$result" "$TEST_IMAGE"
 	killTestImageCommand
 	result=$(processListCommand)
 	assertNotContainsPrinted "$result" "$TEST_IMAGE"
 }

oneTimeTearDown() {
    #need this to suppress tearDown on script EXIT
    [[ "${_shunit_name_}" = 'EXIT' ]] && return 0

	echo "Running teardown..."
	echo "Killing Test image (if running)."
	kill $(pgrep -l -f $TEST_IMAGE.image | cut -d ' ' -f1) > /dev/null
	echo "Deleting Test image."
	deleteTestImageCommand
}

# Load shUnit2.
. $SHUNIT
