"
Remove an image from the hard disk. Can be applied to multiple images at the same time.
"
Class {
	#name : 'PhLDeleteImageCommand',
	#superclass : 'PhLImageCommand',
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLDeleteImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDelete;
		shortcutKey: $x actionModifier;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : 'accessing' }
PhLDeleteImageCommand >> canBeExecuted [ 
	^ self imagesPresenter selectedImages notEmpty
]

{ #category : 'executing' }
PhLDeleteImageCommand >> execute [
	| images imageNames confirmMessage answer |
	
	images := self imagesPresenter selectedImages.
	imageNames := images collect: #name.
	confirmMessage := 'Delete {1} image{2}?
{3}' format: {
		images size . 
		images size > 1 ifTrue: [ 's' ] ifFalse: [ '' ].
		(imageNames joinUsing: String cr)
	}.
	
	answer := self imagesPresenter newConfirmation
		parentWindow: self context window;
		title: 'Delete';
		message: confirmMessage;
		confirm.
	answer ifFalse: [ ^ self ].

	self context application showWaitCursorWhile: [ 
		self imagesPresenter imageRepository deleteImages: images ]
]

{ #category : 'initialization' }
PhLDeleteImageCommand >> initialize [
	super initialize.
	self
		name: 'Delete';
		description: 'Delete the selected Pharo images'
]
