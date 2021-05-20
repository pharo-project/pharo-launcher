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
PhLCreateImageFromTemplateCommand >> addDescriptionIfAny [
	| description |
	description := self templatesPresenter description.
	description isNotEmpty
		ifTrue: [ image description: description ].
]

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
PhLCreateImageFromTemplateCommand >> createImage [
	| name |

	name := self templatesPresenter imageName.
	name isEmptyOrNil ifTrue: [ ^ self ].
	
	image := self templatesPresenter imageRepository
		extractTemplate: self templatesPresenter singleTemplate
		to: name.
	self addInitializationScriptMetadataIfPresent.
	self addDescriptionIfAny.
	self templatesPresenter application imageRepositoryChanged: image.

	^ image
]

{ #category : #executing }
PhLCreateImageFromTemplateCommand >> execute [
	
	[ ^ self createImage ]
		on: PhLCorruptedTemplateError
		do: [ :error | 
			UIManager default
				alert: 'This template appears to be corrupted! Please try again.' ]
]

{ #category : #initialization }
PhLCreateImageFromTemplateCommand >> initialize [
	super initialize.
	self
		name: 'Create image';
		description: 'Create a new image from the selected template'
]
