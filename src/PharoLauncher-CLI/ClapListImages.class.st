"
https://github.com/Bajger/Pharo-snippets/blob/master/pharoLauncherCmdLine-description.md

"
Class {
	#name : #ClapListImages,
	#superclass : #Object,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
ClapListImages class >> listImages [
	<commandline>
	^ (ClapCommand withName: 'listImages')
		description: 'Lists all downloaded images on local computer.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				self outputListImagesAsSton. 
				ston exitSuccess ].
         self outputListImages 
		 ]
]

{ #category : #'instance creation' }
ClapListImages class >> outputListImages [
	self new outputListImages
]

{ #category : #'instance creation' }
ClapListImages class >> outputListImagesAsSton [
	self new outputListImagesAsSton
]

{ #category : #initialization }
ClapListImages >> initialize [

	stream := VTermOutputDriver stdout.
	repository := PhLDirectoryBasedImageRepository default.
]

{ #category : #printing }
ClapListImages >> outputListImages [

	repository images
		do: [ :anImage | stream nextPutAll: anImage name ]
]

{ #category : #printing }
ClapListImages >> outputListImagesAsSton [

	stream nextPutAll: (STON toString: (repository images collect: [:each | each file ]))
]

{ #category : #accessing }
ClapListImages >> repository: aPhLMockImageRepository [ 
	repository := aPhLMockImageRepository
]

{ #category : #accessing }
ClapListImages >> stream: aWriteStream [ 
	stream := aWriteStream
]
