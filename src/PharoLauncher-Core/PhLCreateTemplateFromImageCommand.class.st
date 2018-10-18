"
Create a new local template based on the selected image.
"
Class {
	#name : #PhLCreateTemplateFromImageCommand,
	#superclass : #PhLImageCommand,
	#instVars : [
		'newTemplateName'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLCreateTemplateFromImageCommand class >> group [
	^ 3
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand class >> icon [
	^ self iconNamed: #smallNewIcon
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand class >> positionInGroup [
	^ 10
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand class >> title [
	^ 'Create Template'
]

{ #category : #action }
PhLCreateTemplateFromImageCommand >> execute [
	| name |
	name := self newTemplateName.
	name ifNil: [ PhLCommandCancellation signal ].
	self ensure: name isNotEmpty.
	self model templateRepository createLocalTemplateFrom: self model singleImage named: name
]

{ #category : #accessing }
PhLCreateTemplateFromImageCommand >> newTemplateName [
	^ newTemplateName ifNil: [ newTemplateName := self model requestNewTemplateName: self model singleImageName ]
]
