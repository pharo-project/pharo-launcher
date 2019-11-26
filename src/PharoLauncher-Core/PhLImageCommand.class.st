"
Superclass of all commands that are applied to one image or multiple images.
"
Class {
	#name : #PhLImageCommand,
	#superclass : #CmCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLImageCommand >> canBeExecuted [
	^ self imagesPresenter hasSingleImageSelected
]

{ #category : #accessing }
PhLImageCommand >> imagesPresenter [
	^ self context
]

{ #category : #initialization }
PhLImageCommand >> initialize [
	super initialize.
	self description: self class comment
]
