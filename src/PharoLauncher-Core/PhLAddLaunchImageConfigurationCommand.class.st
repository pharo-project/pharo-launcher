Class {
	#name : #PhLAddLaunchImageConfigurationCommand,
	#superclass : #PhLImageCommand,
	#classVars : [
		'CommandAnnouncer',
		'QuitOnLaunch',
		'WarnOnArchMismatch'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand class >> icon [

	^ self iconNamed: #configuration
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand class >> title [
	^ 'Launch Configurations...'
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> execute [
	self model hasSingleImageSelected
		ifTrue: [ self launchSelectedImage ]
]

{ #category : #testing }
PhLAddLaunchImageConfigurationCommand >> isApplicable [
	^ self model hasSingleImageSelected or: [self model hasNoSelection ]
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> launchImage: aPhLImage [
	[ aPhLImage launchWithSettings: true ]
		on: PhLError
		do: [ :error | error uiAlert ].
	self class quitOnLaunch
		ifTrue: [ self quit ]
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> launchImageFromDisk [
	| imagePath |
	imagePath := UIManager default 
		chooseFullFileName: 'Open a Pharo image'
		extensions: #('image') 
		path: FileLocator home 
		preview: false.
	imagePath ifNil: [ ^ self ].
	imagePath asFileReference isFile ifFalse: [ ^self ].
	self launchImage: (PhLImageModel on: (PhLImage location: imagePath asFileReference))
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> launchSelectedImage [

	(PhlLaunchConfigurationEditor on: self model singleImage) openWithSpec
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand >> pharoStableImagePath [
	| img |
	img := (self resourcesPath  / 'images' / 'pharo-stable.zip') asFileReference.
	^ img exists 
		ifTrue: [ img ]
		ifFalse: [ nil ]
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> quit [
	(PhLQuitCommand on: self model) execute
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand >> resourcesPath [
	| vmDirectory |
	
	vmDirectory := Smalltalk vm binary parent.

	Smalltalk os isMacOSX ifTrue: [ ^ vmDirectory parent / 'Resources' ].
	Smalltalk os isUnix ifTrue: [ ^ vmDirectory parent/ 'shared' ].
	Smalltalk os isWindows ifTrue: [ ^ vmDirectory ].
]
