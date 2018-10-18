"
Superclass of all commands that are applied to one image or multiple images.
"
Class {
	#name : #PhLImageCommand,
	#superclass : #PhLCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #testing }
PhLImageCommand class >> isAbstract [
	^ self name = 'PhLImageCommand'
]

{ #category : #testing }
PhLImageCommand >> isApplicable [
	^ super isApplicable and: [ self model hasSingleImageSelected ]
]

{ #category : #testing }
PhLImageCommand >> validateModelIntegrity [
	| missingImages |
	
	missingImages := self model selectedImages reject: [ :img | img file exists ].
	
	^ missingImages ifEmpty: [ true ] ifNotEmpty: [ 
		|names|
		names := (missingImages collect: #name) joinUsing: ',' last: ' and '. 
		self model newInformation 
				message: 'Unable to ', self class title, ': ', names, '! (File not found)'; 
				abort.
		self model imageRepository contentsChanged.
		false ]
]
