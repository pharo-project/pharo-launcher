"
Remove an image from the hard disk. Can be applied to multiple images at the same time.
"
Class {
	#name : #PhLDeleteImageCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLDeleteImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDeleteIcon;
		shortcutKey: $x meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #accessing }
PhLDeleteImageCommand >> canBeExecuted [ 
	^ self imagesPresenter selectedImages notEmpty
]

{ #category : #accessing }
PhLDeleteImageCommand >> execute [
	| images imageNames confirmMessage answer |
	images := self imagesPresenter selectedImages.
	imageNames := images collect: #name.
	confirmMessage := 'Are you sure you want to delete ', (imageNames joinUsing: ', ' last: ' and ').
	answer := self imagesPresenter newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer ifFalse: [ ^ self ].

	UIManager default showWaitCursorWhile:
		[ self imagesPresenter imageRepository deleteImages: images ].
]

{ #category : #initialization }
PhLDeleteImageCommand >> initialize [
	super initialize.
	self
		name: 'Delete';
		description: 'Delete the selected Pharo images'
]
