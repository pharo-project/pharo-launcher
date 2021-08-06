"
You can use me to easily package an image.
It includes the shipping of the VM as well as a run script for the current image.
It can also the generation of a run script using pharo-launcher.
"
Class {
	#name : #PhLImagePackageCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'image'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImagePackageCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #package
]

{ #category : #'command line' }
PhLImagePackageCliCommand class >> launcherCmdDescription [
	^ 'Creates a script to launch an image.'
]

{ #category : #'command line - arguments' }
PhLImagePackageCliCommand class >> launcherCmdPositionals [

	^ {((ClapPositional id: #existingImageName)
				description: 'Local image name to create the launch script.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'need an image to create the script' . ];
					yourself).
		((ClapPositional id: #location)
				description: 'Local image name to create the launch script.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app |NotFound ];
					yourself).
		((ClapPositional id: #vmName)
				description: 'Local vm to put in the package';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | 'default' ];
					yourself)
	}
]

{ #category : #copying }
PhLImagePackageCliCommand >> copyFilesOf: anImage at: aDirectory [
	((anImage file parent childrenMatching: '*.image') at: 1)
		copyTo: (aDirectory , '/' , anImage name , '.image') asFileReference.
	((anImage file parent childrenMatching: anImage name,'.sh') at: 1)
		copyTo: (aDirectory , '/' , anImage name , '.sh') asFileReference.
	((anImage file parent childrenMatching: anImage name,'.changes') at: 1)
		copyTo: (aDirectory , '/' , anImage name , '.changes') asFileReference.
	((anImage file parent parent parent / 'vms' childrenMatching: self vmName) at: 1)
		copyAllTo: (aDirectory , '/', self vmName) asFileReference
]

{ #category : #creation }
PhLImagePackageCliCommand >> createDirectoryAccordingToPath: aPath [ 
	aPath asFileReference ensureCreateDirectory 
]

{ #category : #creation }
PhLImagePackageCliCommand >> createLaunchScript: anImage [
	anImage launchScriptName
		writeStreamDo: [ :stream | stream nextPutAll: anImage launchScript ].
	LibC runCommand: 'chmod +x ',anImage launchScriptName fullName
	
]

{ #category : #'script generation' }
PhLImagePackageCliCommand >> createLaunchScriptNew: anImage [
	anImage launchScriptName
		writeStreamDo: [ :stream | stream nextPutAll: (self launchScript: anImage) ].
	
]

{ #category : #accessing }
PhLImagePackageCliCommand >> executeWithImage: anImage [
	| userNewDirectory |
	self image: anImage.
	userNewDirectory := self location , '/' , anImage name.
	self createLaunchScriptNew: anImage.
	self createDirectoryAccordingToPath: userNewDirectory.
	[ self copyFilesOf: anImage at: userNewDirectory ]
		on: FileExists
		do: [ ^ (self outStream
				nextPutAll: 'a File with the image name already exists at this location'; newLine )].
	LibC runCommand: 'find ' , self location , '/"' , anImage name , '"/' , self vmName, ' -type f -exec chmod +x {} \;'.
	LibC runCommand: 'find ' , self location , '/"' , anImage name , '" -iname "', anImage name , '.sh" -type f -exec chmod +x {} \;'
]

{ #category : #accessing }
PhLImagePackageCliCommand >> image [ 
	^image 
]

{ #category : #accessing }
PhLImagePackageCliCommand >> image: anImage [
	image := anImage 
]

{ #category : #'script generation' }
PhLImagePackageCliCommand >> launchScript: anImage [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: '#!/usr/bin/env bash';
			lf;
			nextPutAll: self vmName;
			nextPutAll: '/pharo';
			nextPutAll: ' "';
			nextPutAll: anImage name;
			nextPutAll: '.image"';
			lf.
	]
]

{ #category : #accessing }
PhLImagePackageCliCommand >> location [
	^ (arguments at: #location) value: self
]

{ #category : #'default actions' }
PhLImagePackageCliCommand >> selectDefaultVm [
	^ (self image pharoVersion, '-x64' )   . 

]

{ #category : #'find-select' }
PhLImagePackageCliCommand >> vmName [
	| arg |
	arg := (arguments at: #vmName) value: self.
	arg = 'default' ifTrue:[ arg := self selectDefaultVm ].
	^arg
]
