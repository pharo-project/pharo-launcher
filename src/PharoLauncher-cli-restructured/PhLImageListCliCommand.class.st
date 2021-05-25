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
	#instVars : [
		'repository',
		'stream'
	],
	#category : #'PharoLauncher-cli-restructured'
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
   self outputListImages.
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> initialize [

	stream := VTermOutputDriver stdout.
	repository := PhLDirectoryBasedImageRepository default.
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> outputListImages [

	repository images
		do: [ :anImage | stream nextPutAll: anImage name. stream cr.stream nextPutAll:' '. ]
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> repository: aPhLMockImageRepository [ 
	repository := aPhLMockImageRepository
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
