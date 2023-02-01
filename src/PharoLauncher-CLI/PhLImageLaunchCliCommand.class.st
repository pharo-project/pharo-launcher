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
	#instVars : [
		'useScript'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> addLauncherFlagsTo: aCommandSpec [
	
	aCommandSpec 
		addFlagWithPositional: #script 
		description: 'Determines a path to the script when launching an Image.' 

"
	^ {(ClapFlag id: #script)
			description: 'Allows to use a script when launching an Image ';
			meaning: [ :arg :app | 
				app useScript.
				(arg at: #scriptPath) word ];
			implicitMeaning: [ :arg :app |  ];
			add: ((ClapPositional id: #scriptPath)
					description: 'Path of the launch script to use.';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [ :arg :app | ^ app ])}"
]

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	aCommandSpec 
		addPositional: #existingImageName 
		description: 'Specifies the local image name to be launched.'.

"
	^ {((ClapPositional id: #existingImageName)
		description: 'Determines local image name to be launched.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app |NotFound 
        signal: 'An argument is missing, please specify the local image name to launch.'];
		yourself)}"
]

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #launch 
]

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> launcherCmdDescription [

	^ 'Launches image with using default (auto-detected) VM.'
]

{ #category : #checking }
PhLImageLaunchCliCommand >> checkScriptValidity: aScriptPath [
	(aScriptPath asFileReference exists
		and: [ aScriptPath asFileReference isFile ])
		ifFalse: [ self errorStream nextPutAll: 'script not found'.
			^ false ].
	aScriptPath asFileReference extension = 'st'
		ifFalse: [ self errorStream nextPutAll: 'wrong script extension'.
			^ false ].
	^ true
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> executeWithImage: anImage [

	| script |
	script := self script.
	self isUsingScript
		ifTrue: [ (self checkScriptValidity: script)
				ifFalse: [ ^ self ].
			anImage
				shouldRunInitializationScript: true;
				initializationScript: script asFileReference ].
	[anImage vmManager checkImageArchitecture] on:PhLArchitectureMismatchWarning do:[ self errorStream
						nextPutAll: 'Architecture mismatch, still running image if possible';
						newLine].
	PhLLaunchImageCommand warnOnArchMismatch: false.
	self logLaunchOfImage: anImage.
	anImage launch
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> initialize [ 
	super initialize.
	useScript := false
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> isUsingScript [
	^ useScript 
]

{ #category : #logging }
PhLImageLaunchCliCommand >> logLaunchOfImage: anImage [

	| imgConfig |
	imgConfig := anImage defaultLaunchConfiguration.
	self logInfoMessage: ('Launching image with command: "{1}".' format: { imgConfig commandString })
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> script [
	^ (arguments at: #script) value: self
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> useInitializationScript [
	useScript := true
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> useScript [
	useScript := true
]
