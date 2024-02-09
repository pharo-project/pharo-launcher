"
I represent Pharo Image delete sub-command invoked from cmd line of Pharo Launcher. My responsibility is to delete local images within Pharo launcher based on specified image name. 

I declare: 
- mandatory positional with existing image name, based on which is image deleted

I execute:
- delete local image based on specified image name
"
Class {
	#name : #PhLImageDeleteCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageDeleteCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	aCommandSpec 
		addFlag: #force
		description: 'Force the image deletion without asking confirmation'
]

{ #category : #'command line - arguments' }
PhLImageDeleteCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #existingImageName 
		description: 'Local image name to be deleted.')
]

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #delete 
]

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> launcherCmdDescription [

	^ 'Deletes the local image, including image directory content.'
]

{ #category : #private }
PhLImageDeleteCliCommand >> askConfirmation: anImage [

	^ self cliInputRequest
		question: ('Are your sure you want to delete ''{1}''? [y|n]' format: { anImage name });
		validation: [ :aString | 
				aString size = 1 and: [ aString first asLowercase = $y or: [ aString first asLowercase = $n ] ] ];
		validationErrorMessage: 'Please provide a valid answer: y or n';
		answer
]

{ #category : #'command execution' }
PhLImageDeleteCliCommand >> basicExecute [

	| anImage |
	anImage := self selectedImage.
	
	(self isDeletionConfirmed: anImage) ifFalse: [ ^ self ].
	self imageRepository deleteImage: anImage
]

{ #category : #testing }
PhLImageDeleteCliCommand >> isDeletionConfirmed: anImage [

	self isForceDelete ifTrue: [ ^ true ].
	^ (self askConfirmation: anImage) first asLowercase = $y
]

{ #category : #testing }
PhLImageDeleteCliCommand >> isForceDelete [

	^ self hasFlag: #force
]
