"
Extract the selected template to a new image.
"
Class {
	#name : #PhLCreateImageFromTemplateCommand,
	#superclass : #PhLTemplateCommand,
	#instVars : [
		'image'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #executing }
PhLCreateImageFromTemplateCommand >> addInitializationScriptMetadataIfPresent [
	| initScript |
	initScript := self templatesPresenter initializationScript.
	(initScript exists and: [ initScript contents isNotEmpty ])
		ifTrue: [ image initializationScript: initScript ].
]

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
	
	[ image := self templatesPresenter imageRepository 
		extractTemplate: self templatesPresenter singleTemplate 
		to: name.
	self addInitializationScriptMetadataIfPresent.
	self templatesPresenter application imageRepositoryChanged.
	^ image ]
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
