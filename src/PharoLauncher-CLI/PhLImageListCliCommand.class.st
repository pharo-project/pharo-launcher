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
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #list 
]

{ #category : #'command line' }
PhLImageListCliCommand class >> launcherCmdDescription [

	^ 'Lists all downloaded images on local computer.'
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> execute [
   self listImages.
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> listImages [

	self imageRepository  images
		do: [ :anImage | self outStream nextPutAll: anImage name. self outStream cr.self outStream nextPutAll:' '. ]
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> listImagesAsSton [
   | stonOutput |
	stonOutput :=''.
	self pharoLauncherModel imageBaseRepository images
		do: [ :anImage | stonOutput:= stonOutput,STON toString: anImage.].
	self outStream nextPutAll: stonOutput.
	
]
