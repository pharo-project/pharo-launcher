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

	(aCommandSpec 
		addPositional: #existingImageName 
		description: 'Local image name to recreate.')
	implicitMeaning: [:arg :app | self raiseMissingImageToRecreate]
]

{ #category : #'command line' }
PhLImageRecreateCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #recreate 
]

{ #category : #'command line' }
PhLImageRecreateCliCommand class >> launcherCmdDescription [

	^ 'Recreates the local image, the image argument determines the image name to recreate.'
]

{ #category : #'error signalling' }
PhLImageRecreateCliCommand class >> raiseMissingImageToRecreate [

	^ NotFound signal: 'An argument is missing, please specify the image name to recreate.'
]

{ #category : #'command execution' }
PhLImageRecreateCliCommand >> basicExecute [ 
	
	self imageRepository recreateImage: self selectedImage
]
