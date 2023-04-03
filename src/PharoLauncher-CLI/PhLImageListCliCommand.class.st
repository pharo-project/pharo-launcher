"
I represent Pharo Image list sub-command invoked from cmd line of Pharo Launcher. My responsibility is to list local images within Pharo launcher that were previously created or imported. 

I declare: 
- optional flag for stonOutput

I execute:
- list local images with detailed information about image name, used VM, architecture, local dir, etc.
"
Class {
	#name : #PhLImageListCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageListCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	aCommandSpec 
		addFlagWithPositional: #name
		description: 'Determines the name of image (or its sub-part) to list local images.'.

	self addPrintFlagsTo: aCommandSpec.
]

{ #category : #'command line' }
PhLImageListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #list 
]

{ #category : #'command line' }
PhLImageListCliCommand class >> launcherCmdDescription [

	^ 'Lists all local images from Pharo laucher repository.'
]

{ #category : #'command execution' }
PhLImageListCliCommand >> basicExecute [ 

	self listImages
]

{ #category : #listing }
PhLImageListCliCommand >> imagesFromName: aSubtring [
	| imagesIncludingSubstring |
	imagesIncludingSubstring := self imageRepository images
		select: [ :anImage | anImage name includesSubstring: aSubtring ].
	^ imagesIncludingSubstring
]

{ #category : #listing }
PhLImageListCliCommand >> listImages [

	| images |
	images := (self hasFlag: #name)
		ifTrue: [ self imagesFromName: self name ]
		ifFalse: [ self imageRepository images ].

	self list: images
]

{ #category : #'accessing arguments' }
PhLImageListCliCommand >> name [

	^ self positional: #name
]
