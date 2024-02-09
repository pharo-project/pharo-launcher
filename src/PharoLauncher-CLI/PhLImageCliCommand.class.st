"
I represent Pharo Image sub-command of Pharo Launcher. My responsibility is to take care of Pharo image sub-commands. 

I use: 
 - Pharo launcher root command to declare my other sub-commands.

I declare: 
- copy, create, delete, info initScriptsDir, launch, list, update sub-commands

I execute:
- just printing help about my sub-commands relevant for Pharo images
"
Class {
	#name : #PhLImageCliCommand,
	#superclass : #PhLCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #image
]

{ #category : #'command line' }
PhLImageCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to management of local Pharo images.'
]

{ #category : #'error signalling' }
PhLImageCliCommand class >> raiseImageNotFound: anImageName [

	^ NotFound signal: ('Local image ''{1}'' not found. Please enter a correct local image.' format: { anImageName  })
]

{ #category : #'error signalling' }
PhLImageCliCommand class >> raiseNewImageNotFound [

	^ NotFound signal: 'An argument is missing. Please specify the name for the new Pharo image.'
]

{ #category : #private }
PhLImageCliCommand >> askForImageNumberIn: imagesToList [
	
	^ self cliInputRequest
		question: 'Select the image number: ';
		transform: [ :aString | Integer readFrom: aString  ];
		validation: [ :aNumber | aNumber between: 1 and: imagesToList size ];
		validationErrorMessage: 'Please provide a valid value: image sequence number from the above list!';
		answer
]

{ #category : #'find-select' }
PhLImageCliCommand >> findByPath: anImageName [
	(anImageName asFileReference exists
		and: [ anImageName asFileReference isFile ])
		ifFalse: [ self class raiseImageNotFound: anImageName ].
	^ PhLImage location: anImageName asFileReference
]

{ #category : #accessing }
PhLImageCliCommand >> findImage [
	^ self findImage: self imageName  
]

{ #category : #accessing }
PhLImageCliCommand >> findImage: anImageName [
	^ [ self findInRepository: anImageName ]
		on: NotFound
		do: [ self findByPath: anImageName ]
]

{ #category : #'finding/searching' }
PhLImageCliCommand >> findInRepository: anImageName [
	^ self imageRepository imageNamed: anImageName asLowercase
]

{ #category : #accessing }
PhLImageCliCommand >> imageName [

	^ self positional: #existingImageName
]

{ #category : #private }
PhLImageCliCommand >> listImagesAndAskForImageNumber [
	
	| imageNumber imagesToList |
	
	imagesToList := self imageRepository images sorted: [:a :b | b lastModification <= a lastModification].
	self list: imagesToList.
	
	imageNumber := self askForImageNumberIn: imagesToList.		
	^ imagesToList at: imageNumber.
]

{ #category : #private }
PhLImageCliCommand >> modelClass [
	^ self class environment at: #PhLImage
]

{ #category : #private }
PhLImageCliCommand >> selectedImage [

	[ self imageName ]
		on: NotFound "no image name specified"
		do: [ ^ self listImagesAndAskForImageNumber ].
	
	^ self findImage
]

{ #category : #accessing }
PhLImageCliCommand >> targetName [

	^ self positional: #newImageName
]
