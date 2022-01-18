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

{ #category : #'as yet unclassified' }
PhLImageCliCommand class >> imageNotFoundMessage [
	^ 'Please enter a correct local image.'
]

{ #category : #'command line' }
PhLImageCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to management of local Pharo images.'
]

{ #category : #'command line - subcommands' }
PhLImageCliCommand class >> launcherCmdSubcommands [

	^ (self subclasses copyWith: PhLImageCreateFromBuildCliCommand) collect: #asCliCommand
]

{ #category : #'command execution' }
PhLImageCliCommand >> execute [
	[ self executeWithImage: self findImage ]
		on: NotFound
		do: [:ex | ^ self logExceptionMessage: ex printString ]
]

{ #category : #'find-select' }
PhLImageCliCommand >> findByPath: anImageName [
	(anImageName asFileReference exists
		and: [ anImageName asFileReference isFile ])
		ifFalse: [ NotFound signal: self class imageNotFoundMessage ].
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
	^ (arguments at: #existingImageName)
		value: self;
		word
]

{ #category : #printing }
PhLImageCliCommand >> logImageNotFoundMessage [
	self errorStream nextPutAll: self class imageNotFoundMessage.
	self errorStream newLine.
]

{ #category : #private }
PhLImageCliCommand >> modelClass [
	^ self class environment at: #PhLImage
]
