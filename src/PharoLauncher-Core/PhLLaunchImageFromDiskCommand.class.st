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
		iconName: self;
		iconProvider: self;
		yourself
]

{ #category : #executing }
PhLLaunchImageFromDiskCommand >> execute [
	| imageFile |
	imageFile := self imagesPresenter newFileRequest 
		title: 'Open a Pharo image';
		extensionsToShow: #('image');
		path: FileLocator home;
		chooseFile.
	imageFile ifNil: [ ^ self ].
	imageFile isFile ifFalse: [ ^self ].
	PhLLaunchImageCommand new 
		launchImage: (PhLImage location: imageFile).
]

{ #category : #accessing }
PhLLaunchImageFromDiskCommand >> iconNamed: anIconName [
	^ (super iconNamed: #open) mergeWith: (super iconNamed: #smallDoItIcon) at:0@0
]

{ #category : #initialization }
PhLLaunchImageFromDiskCommand >> initialize [
	super initialize.
	self name: 'From disk'
]
