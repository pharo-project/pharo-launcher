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
	self assert: (self outputString isEmpty or: [ self outputString includesSubstring: 'Pharo'])
]

{ #category : #tests }
PhLImageProcessListCliCommandTest >> testImageProcesListFrom [

	|processListCmd aString resultArray|
	processListCmd := PhLImageProcessListCliCommand new.
	aString := String streamContents: [: aStream | 
		aStream 
			nextPutAll: '1111-|-path/to/vm-|-path/to/1st.image-|-May 1 2023'; 
			nextPutAll: OSPlatform current lineEnding; 
			nextPutAll: '2222-|-path/to/2nd-vm-|-path/to/2nd.image-|-Jun 2 2023';
			nextPutAll: OSPlatform current lineEnding; 
			nextPutAll: '3333-|-path/to/3rd-vm-|-path/to/3rd.image-|-Jul 3 2023';
			nextPutAll: OSPlatform current lineEnding
		].
	resultArray := processListCmd imageProcesListFrom: aString.
	self assert: resultArray size equals: 3.
	 


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
