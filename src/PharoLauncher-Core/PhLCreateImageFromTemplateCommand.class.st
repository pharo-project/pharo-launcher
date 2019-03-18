"
Extract the selected template to a new image.
"
Class {
	#name : #PhLCreateImageFromTemplateCommand,
	#superclass : #PhLTemplateCommand,
	#instVars : [
		'newImageName'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLCreateImageFromTemplateCommand class >> group [
	^ 1
]

{ #category : #accessing }
PhLCreateImageFromTemplateCommand class >> icon [
	^ self iconNamed: #smallNewIcon
]

{ #category : #accessing }
PhLCreateImageFromTemplateCommand class >> title [
	^ 'Create image'
]

{ #category : #action }
PhLCreateImageFromTemplateCommand >> execute [
	| name |

	name := self newImageName.
	name ifNil: [ ^ self ].
	self ensure: (model isNewImageNameValid: name).
	model imageRepository 
		extractTemplate: model singleTemplate 
		to: name
]

{ #category : #accessing }
PhLCreateImageFromTemplateCommand >> newImageName [
	^ newImageName ifNil: [ newImageName := self model requestNewImageName: self model singleTemplateName ]
]

{ #category : #accessing }
PhLCreateImageFromTemplateCommand >> newImageName: anObject [
	newImageName := anObject
]
