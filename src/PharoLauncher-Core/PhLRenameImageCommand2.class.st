"
Rename the currently selected image and move the files accordingly.
"
Class {
	#name : #PhLRenameImageCommand2,
	#superclass : #PhLImageCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLRenameImageCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #workspaceIcon;
		shortcutKey: $r meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLRenameImageCommand2 >> execute [
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self ensure: (self model isNewImageNameValid: name).
	self model imageRepository renameImage: self model singleImage to: name
]

{ #category : #initialization }
PhLRenameImageCommand2 >> initialize [
	super initialize.
	self
		basicName: 'Rename';
		basicDescription: 'Rename the currently selected image and move the files accordingly.'
]

{ #category : #private }
PhLRenameImageCommand2 >> newImageName [
	^ self imagesPresenter requestNewImageName: self imagesPresenter singleImageName
]

{ #category : #private }
PhLRenameImageCommand2 >> newImageName: aString [ 
	^ self imagesPresenter newRequest 
		title: 'Image name?';
		initialAnswer: aString;
		validateAnswer: [ :answer | (self imagesPresenter imageRepository hasImageNamed: answer) not ];
		request
]
