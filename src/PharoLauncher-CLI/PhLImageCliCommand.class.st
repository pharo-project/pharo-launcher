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
	^ self newLauncherCommand: #image
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
PhLImageCliCommand >> checkOS [

	OSPlatform current isWindows ifTrue: [ self raiseOperationNotSupported ]
]

{ #category : #'command execution' }
PhLImageCliCommand >> execute [
	
	[ self executeWithImage: self findImage ]
	on: NotFound, PhLError
	do: [:ex | 
		self logExceptionMessage: ex printString. 
		self context exitFailure
	]
]

{ #category : #'command execution' }
PhLImageCliCommand >> executeWithImage: anImage [

	self subclassResponsibility 
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
PhLImageCliCommand >> modelClass [
	^ self class environment at: #PhLImage
]

{ #category : #'error signalling' }
PhLImageCliCommand >> raiseOperationNotSupported [

	^ PhLProcessCommandError signal: 'Launcher command currently not supported on OS Windows.'
]

{ #category : #accessing }
PhLImageCliCommand >> targetName [

	^ self positional: #newImageName
]
