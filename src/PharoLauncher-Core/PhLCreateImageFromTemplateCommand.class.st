"
Extract the selected template to a new image.
"
Class {
	#name : #PhLCreateImageFromTemplateCommand,
	#superclass : #PhLTemplateCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLCreateImageFromTemplateCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallNewIcon;
		shortcutKey: $s meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLCreateImageFromTemplateCommand >> execute [
	| name |
	name := self templatesPresenter imageName.
	name isEmptyOrNil ifTrue: [ ^ self ].
	
	[ self templatesPresenter imageRepository 
		extractTemplate: self templatesPresenter singleTemplate 
		to: name.
	self templatesPresenter application imageRepositoryChanged. ]
	on: PhLCorruptedTemplateError
	do: [ :error | UIManager default alert: 'This template appears to be corrupted! Please try again.' ].
]

{ #category : #initialization }
PhLCreateImageFromTemplateCommand >> initialize [
	super initialize.
	self
		name: 'Create image';
		description: 'Create a new image from the selected template'
]
