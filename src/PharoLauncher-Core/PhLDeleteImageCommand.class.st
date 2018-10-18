"
Remove an image from the hard disk. Can be applied to multiple images at the same time.
"
Class {
	#name : #PhLDeleteImageCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLDeleteImageCommand class >> icon [
	^ self iconNamed: #smallDeleteIcon
]

{ #category : #accessing }
PhLDeleteImageCommand class >> positionInGroup [
	^ 10
]

{ #category : #accessing }
PhLDeleteImageCommand class >> title [
	^ 'Delete'
]

{ #category : #action }
PhLDeleteImageCommand >> execute [
	| images imageNames confirmMessage answer |
	images := self model selectedImages.
	imageNames := images collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (imageNames joinUsing: ', ' last: ' and ').
	answer := self model newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer
		ifTrue: [ self model imageRepository deleteImages: images ]
]

{ #category : #testing }
PhLDeleteImageCommand >> isApplicable [
	^ self model hasAtLeastOneImageSelected
]
