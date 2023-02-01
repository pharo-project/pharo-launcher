"
Command to reset an image 
"
Class {
	#name : #PhLImageRecreateCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageRecreateCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	aCommandSpec 
		addPositional: #existingImageName 
		description: 'Local image name to recreate.'.

	"^ {((ClapPositional id: #existingImageName)
		description: 'Local image name to recreate.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app |NotFound 
        signal: 'An argument is missing, please specify the image name to recreate.'];
		yourself)}"
]

{ #category : #'command line' }
PhLImageRecreateCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #recreate 
]

{ #category : #'command line' }
PhLImageRecreateCliCommand class >> launcherCmdDescription [

	^ 'Recreates the local image, the image argument determines the image name to recreate.'
]

{ #category : #'command execution' }
PhLImageRecreateCliCommand >> executeWithImage: anImage [ 
	self imageRepository recreateImage: anImage
]
