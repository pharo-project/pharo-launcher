"
Open the image creation UI.
"
Class {
	#name : 'PhLOpenNewImageWindowCommand',
	#superclass : 'PhLGeneralCommand',
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLOpenNewImageWindowCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallNew;
		shortcutKey: $n actionModifier;
		yourself
]

{ #category : 'executing' }
PhLOpenNewImageWindowCommand >> execute [

	^ (PhLTemplatesPresenter
			newApplication: self application
			model: PhLTemplateGroupRepository default)
		owner: self context window;
		open;
		yourself
]

{ #category : 'initialization' }
PhLOpenNewImageWindowCommand >> initialize [
	super initialize.
	self
		name: 'New';
		description: self class comment.
]
