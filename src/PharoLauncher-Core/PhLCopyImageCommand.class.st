"
Copy one image to another name.
"
Class {
	#name : #PhLCopyImageCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLCopyImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallCopyIcon;
		shortcutKey: $c meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLCopyImageCommand >> execute [
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self imagesPresenter ensure: (self imageRepository isNewImageNameValid: name).
	UIManager default showWaitCursorWhile:
		[ self imageRepository
			copyImage: self imagesPresenter singleImage
			to: name ]
]

{ #category : #executing }
PhLCopyImageCommand >> imageRepository [
	^ self imagesPresenter imageRepository
]

{ #category : #initialization }
PhLCopyImageCommand >> initialize [
	super initialize.
	self
		name: 'Copy image';
		description: 'Copy the currently selected image to the new name.'
]

{ #category : #'instance creation' }
PhLCopyImageCommand >> newImageName [
	^ self newImageName: self imagesPresenter singleImageName
]

{ #category : #'instance creation' }
PhLCopyImageCommand >> newImageName: aString [ 
	^ self imagesPresenter newRequest 
		title: 'Image name?';
		initialAnswer: aString;
		validateAnswer: [ :answer | (self imagesPresenter imageRepository hasImageNamed: answer) not ];
		request
]
