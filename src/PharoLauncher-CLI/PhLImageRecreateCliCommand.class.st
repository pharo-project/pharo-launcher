"
Command to reset an image 
"
Class {
	#name : #PhLImageRecreateCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageRecreateCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #recreate 
]

{ #category : #'command line' }
PhLImageRecreateCliCommand class >> launcherCmdDescription [
	^ 'Recreate an image, the image argument gives the image name to recreate.'
]

{ #category : #'command line - arguments' }
PhLImageRecreateCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Local image name to recreate.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app |NotFound 
        signal: 'one argument is missing, no image name to recreate' .  ];
		yourself)}
]

{ #category : #'command execution' }
PhLImageRecreateCliCommand >> executeWithImage: anImage [ 
	self imageRepository recreateImage: anImage
]
