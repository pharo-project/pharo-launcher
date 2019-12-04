"
Launch an image from the filesystem without importing it into Pharo Launcher
"
Class {
	#name : #PhLLaunchImageFromDiskCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLLaunchImageFromDiskCommand >> asSpecCommand [
	^ super asSpecCommand
		"iconName: #smallLoadProject;
		shortcutKey: $d meta;"
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLLaunchImageFromDiskCommand >> execute [
	| imagePath |
	imagePath := self imagesPresenter newFileRequest 
		title: 'Open a Pharo image';
		extensionsToShow: #('image');
		path: FileLocator home;
		chooseFullFileName.
	imagePath ifNil: [ ^ self ].
	imagePath asFileReference isFile ifFalse: [ ^self ].
	PhLLaunchImageCommand new 
		launchImage: (PhLImage location: imagePath asFileReference).
]

{ #category : #initialization }
PhLLaunchImageFromDiskCommand >> initialize [
	super initialize.
	self name: 'Launch from disk'
]
