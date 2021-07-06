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
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #launch 
]

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> launcherCmdDescription [

	^ 'Launches image with using default (auto-detected) VM.'
]

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> launcherCmdFlags [
	^ {(ClapFlag id: #script)
			description: 'Allows to use a script when launching an Image ';
			meaning: [ :arg :app | 
				app useScript.
				(arg at: #scriptPath) word ];
			implicitMeaning: [ :arg :app |  ];
			add: ((ClapPositional id: #scriptPath)
					description: 'Path of the launch script to use.';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [ :arg :app | ^ app ])}
]

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Local image name which will be launched.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app |NotFound 
        signal: 'one argument is missing, you need to precise which image to launch' .  ];
		yourself)}
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
	self outStream
		nextPutAll: 'Launching image';
		newLine.
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
