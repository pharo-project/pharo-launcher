"
Rename the currently selected image and move the files accordingly.
"
Class {
	#name : #PhLRenameImageCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLRenameImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #workspaceIcon;
		shortcutKey: $r meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLRenameImageCommand >> execute [
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self imagesPresenter imageRepository 
		renameImage: self imagesPresenter singleImage 
		to: name
]

{ #category : #initialization }
PhLRenameImageCommand >> initialize [
	super initialize.
	self
		name: 'Rename';
		description: 'Rename the currently selected image and move the files accordingly.'
]

{ #category : #private }
PhLRenameImageCommand >> newImageName [
	^ self newImageName: self imagesPresenter singleImageName
]

{ #category : #private }
PhLRenameImageCommand >> newImageName: aString [ 
	^ self imagesPresenter newRequest 
		title: 'Image name?';
		initialAnswer: aString;
		validateAnswer: [ :answer | (self imagesPresenter imageRepository hasImageNamed: answer) not ];
		request
]
