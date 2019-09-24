"
Extract the selected template to a new image.
"
Class {
	#name : #PhLCreateImageFromTemplateCommand2,
	#superclass : #PhLTemplateCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLCreateImageFromTemplateCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallNewIcon;
		shortcutKey: $s meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLCreateImageFromTemplateCommand2 >> execute [
	| name |
	name := self templatesPresenter imageName.
	name isEmptyOrNil ifTrue: [ ^ self ].
	
	[ self templatesPresenter imageRepository 
		extractTemplate: self templatesPresenter singleTemplate 
		to: name ]
	on: PhLCorruptedTemplateError
	do: [ :error | UIManager default alert: 'This template appears to be corrupted! Please try again.' ].
]

{ #category : #initialization }
PhLCreateImageFromTemplateCommand2 >> initialize [
	super initialize.
	self
		name: 'Create image';
		description: 'Create a new image from the selected template'
]
