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
		addFlagWithPositional: #nameFilter
		description: 'Images listing will be filtered by the provided name filter'.

	self addPrintFlagsTo: aCommandSpec.
]

{ #category : #'command line' }
PhLImageListCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #list 
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
	images := (self hasFlag: #nameFilter)
		ifTrue: [ self imagesFromName: self nameFilter ]
		ifFalse: [ self imageRepository images ].

	self list: images
]

{ #category : #'accessing arguments' }
PhLImageListCliCommand >> nameFilter [

	^ self positional: #nameFilter
]
