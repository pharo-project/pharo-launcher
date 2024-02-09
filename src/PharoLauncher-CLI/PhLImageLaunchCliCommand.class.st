"
I represent Pharo Image launch sub-command invoked from cmd line of Pharo Launcher. My responsibility is to launch local image with auto-detected VM within Pharo launcher based on specified image name. 

I declare: 
- mandatory positional with existing image name, based on which is image launched

I execute:
- launch local image with auto-detected VM
"
Class {
	#name : #PhLImageLaunchCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> addLauncherFlagsTo: aCommandSpec [
	
	aCommandSpec 
		addFlagWithPositional: #script 
		description: 'Determines a path to the script when launching an Image.' 
]

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	aCommandSpec 
		addPositional: #existingImageName 
		description: 'Specifies the local image name to be launched.'
]

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #launch 
]

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> launcherCmdDescription [

	^ 'Launches image with using default (auto-detected) VM.'
]

{ #category : #'command execution' }
PhLImageLaunchCliCommand >> basicExecute [

	| anImage |
	anImage:= self selectedimage.
	self setupScriptForImage: anImage.
	self checkArchitectureForImage: anImage.
	PhLLaunchImageCommand warnOnArchMismatch: false.
	self logLaunchOfImage: anImage.
	anImage launchFrom: FileSystem workingDirectory
]

{ #category : #'accessing arguments' }
PhLImageLaunchCliCommand >> briefPrint [ 
	"Use a simple list of images when launching"
	^ true
]

{ #category : #checking }
PhLImageLaunchCliCommand >> checkArchitectureForImage: anImage [

	[anImage vmManager checkImageArchitecture] 
	on: PhLArchitectureMismatchWarning 
	do:[:warning | self logInfoMessage: warning longDescription]
]

{ #category : #checking }
PhLImageLaunchCliCommand >> checkScriptValidity: aScriptPath [

	(aScriptPath asFileReference exists
		and: [ aScriptPath asFileReference isFile ])
		ifFalse: [^ self raiseScriptNotFound: aScriptPath].

	aScriptPath asFileReference extension = 'st'
		ifFalse: [^ self raiseWrongScriptExtension: aScriptPath]
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> isUsingScript [
	
	^ self hasFlag: #script
]

{ #category : #logging }
PhLImageLaunchCliCommand >> logLaunchOfImage: anImage [

	| imgConfig |
	imgConfig := anImage defaultLaunchConfiguration.
	self logInfoMessage: ('Launching image with command: "{1}".' format: { imgConfig commandString })
]

{ #category : #'error signalling' }
PhLImageLaunchCliCommand >> raiseScriptNotFound: scriptPath [

	^ PhLError signal: ('Launching script for image not found - invalid path to file: {1}.' format: { scriptPath  } )
]

{ #category : #'error signalling' }
PhLImageLaunchCliCommand >> raiseWrongScriptExtension: scriptPath [

	^ PhLError signal: ('Launching script has wrong file extension (should be .st): {1}.' format: { scriptPath  } )
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> script [

	^ self positional: #script
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> setupScriptForImage: anImage [

	| script |
	self isUsingScript ifFalse: [ ^ self ].
	script := self script.
	self checkScriptValidity: script.
	anImage
		shouldRunInitializationScript: true;
		initializationScript: script asFileReference
]
