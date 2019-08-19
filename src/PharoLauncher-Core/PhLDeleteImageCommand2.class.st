"
Remove an image from the hard disk. Can be applied to multiple images at the same time.
"
Class {
	#name : #PhLDeleteImageCommand2,
	#superclass : #PhLImageCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLDeleteImageCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDeleteIcon;
		shortcutKey: $r meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #accessing }
PhLDeleteImageCommand2 >> canBeExecuted [ 
	^ self imagesPresenter selectedImages notEmpty
]

{ #category : #accessing }
PhLDeleteImageCommand2 >> execute [
	| images imageNames confirmMessage answer |
	images := self imagesPresenter selectedImages.
	imageNames := images collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (imageNames joinUsing: ', ' last: ' and ').
	answer := self imagesPresenter newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer
		ifTrue: [ self imagesPresenter imageRepository deleteImages: images ]
]

{ #category : #initialization }
PhLDeleteImageCommand2 >> initialize [
	super initialize.
	self
		basicName: 'Delete';
		basicDescription: 'Delete the selected Pharo images'
]
