"
You can use me to easily package an image.
It includes the shipping of the VM as well as a run script for the current image.
It can also the generation of a run script using pharo-launcher.
"
Class {
	#name : #PhLImagePackageCliCommand,
	#superclass : #PhLImageCliCommand,
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
					yourself)
	}
]

{ #category : #copying }
PhLImagePackageCliCommand >> copyFilesOf: anImage at: aDirectory [
	((anImage file parent childrenMatching: '*.image') at: 1)
		copyTo: (aDirectory , '/' , anImage name , '.image') asFileReference
]

{ #category : #'as yet unclassified' }
PhLImagePackageCliCommand >> createDirectoryAccordingToPath: aPath [ 
	aPath asFileReference ensureCreateDirectory 
]

{ #category : #creating }
PhLImagePackageCliCommand >> createLaunchScript: anImage [
	anImage launchScriptName
		writeStreamDo: [ :stream | stream nextPutAll: anImage launchScript ].
	LibC runCommand: 'chmod +x ',anImage launchScriptName fullName
]

{ #category : #accessing }
PhLImagePackageCliCommand >> executeWithImage: anImage [
	| userNewDirectory |
	userNewDirectory := (self location,'/',anImage name).
	self createLaunchScript: anImage .
	self createDirectoryAccordingToPath: userNewDirectory .
	self copyFilesOf: anImage at: userNewDirectory
	
]

{ #category : #accessing }
PhLImagePackageCliCommand >> location [
	^ (arguments at: #location) value: self
]
