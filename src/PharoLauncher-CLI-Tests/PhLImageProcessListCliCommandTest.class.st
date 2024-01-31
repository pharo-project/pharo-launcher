"
A PhLImageProcessListCliCommandTest is a test class for testing the behavior of PhLImageProcessListCliCommand
"
Class {
	#name : #PhLImageProcessListCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageProcessListCliCommandTest >> testExecute [ 

	self runCommand: #('launcher' 'image' 'processList').
	
	self assertSuccess.
	
	"either there isn't running any image (except currently running launcher) or some image is running (cotaining Pharo term in image arguement of VM path"
	self assert: (self outputString isEmpty or: [ self outputString includesSubstring: 'Pharo' caseSensitive: false])
]

{ #category : #tests }
PhLImageProcessListCliCommandTest >> testImageProcesListFrom [

	|processListCmd aString resultArray|
	processListCmd := PhLImageProcessListCliCommand new.
	aString := String streamContents: [: aStream | 
		aStream 
			nextPutAll: '933 /tmp/PhLLaunchImageTest.61d1f200-02cc-0d00-88d2-05d60e98deae/110-x64/pharo /tmp/Yann-GaÃÂ«l BÃÂ©rÃÂ¨s.61d1f200-02cc-0d00-88d2-05d60e98deae/PharoLauncher.image';
			nextPutAll: OSPlatform current lineEnding; 
			nextPutAll: '1974 /tmp/PhLLaunchImageTest.bb602801-02cc-0d00-88d6-4ed30e98deae/110-x64/pharo /tmp/Yann-GaÃÂ«l BÃÂ©rÃÂ¨s.bb602801-02cc-0d00-88d6-4ed30e98deae/PharoLauncher.image';
			nextPutAll: OSPlatform current lineEnding;
			nextPutAll: '2021 /home/runner/Pharo/vms/110-x64/lib/pharo --headless /tmp/pharo-launcher-tests-launch-image-command.a59b0202-02cc-0d00-88da-288c0e98deae/PharoLauncher.image --no-quit';
			nextPutAll: OSPlatform current lineEnding;
			nextPutAll: '2048 /home/runner/Pharo/vms/110-x64/lib/pharo --headless /tmp/pharo-launcher-tests-launch-image-from-disk-command.509e2802-02cc-0d00-88e0-81d90e98deae/PharoLauncher.image --no-quit';
			nextPutAll: OSPlatform current lineEnding;
			nextPutAll: '2304 /home/runner/Pharo/vms/100-x64/lib/pharo --headless /home/runner/Pharo/images/PhLTestImage/PhLTestImage.image --no-quit '; 
			nextPutAll: OSPlatform current lineEnding;
			nextPutAll: '57499 /Users/dbajger/Documents/Pharo/vms/110-x64/Pharo.app/Contents/MacOS/Pharo /Users/dbajger/Documents/Pharo/images/P11-launcher-dev/P11-launcher-dev.image'
		].
	"each of string lines above represents information about one Pharo process, so there should be 6 processes (PhLImageProcess instances) determined from these lines"
	resultArray := processListCmd imageProcesListFrom: aString.
	self assert: resultArray size equals: 6.

]

{ #category : #tests }
PhLImageProcessListCliCommandTest >> testOsShellArgArray [

	|processListCmd argArray|
	processListCmd := PhLImageProcessListCliCommand new.
	argArray := processListCmd osShellArgArray.
	
	"test whether current PID of vm is filtered from list"
	
	self assert: (argArray first includesSubstring: 'pgrep').
	self assert: (argArray first includesSubstring: ('grep -v ', (processListCmd currentVMPid asString))).
]
