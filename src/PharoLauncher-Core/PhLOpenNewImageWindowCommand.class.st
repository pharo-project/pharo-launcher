"
Open the image creation UI.
"
Class {
	#name : #PhLOpenNewImageWindowCommand,
	#superclass : #PhLGeneralCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLOpenNewImageWindowCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallNew;
		shortcutKey: $n meta;
		yourself
]

{ #category : #executing }
PhLOpenNewImageWindowCommand >> execute [

	^ (PhLTemplatesPresenter 
			newApplication: self application
			model: PhLTemplateGroupRepository default)
		openWithSpec;
		yourself
]

{ #category : #initialization }
PhLOpenNewImageWindowCommand >> initialize [
	super initialize.
	self
		name: 'New';
		description: self class comment.
]
