"
Create a new local template based on the selected image. and remove the selected image
"
Class {
	#name : #PhLCreateTemplateFromImageAndRemoveImageCommand,
	#superclass : #PhLCreateTemplateFromImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLCreateTemplateFromImageAndRemoveImageCommand class >> positionInGroup [
	^ 11
]

{ #category : #accessing }
PhLCreateTemplateFromImageAndRemoveImageCommand class >> title [
	^ 'Create Template and delete image'
]

{ #category : #action }
PhLCreateTemplateFromImageAndRemoveImageCommand >> createTemplate [
	| name |
	name := self newTemplateName.
	name ifNil: [ PhLCommandCancellation signal ].
	self
		ensure: (self model isNewLocalTemplateNameValid: name).
	self model templateRepository
		createLocalTemplateFrom: self model singleImage
		named: name
]

{ #category : #action }
PhLCreateTemplateFromImageAndRemoveImageCommand >> deleteImage [
	"remove image without confirmation"
	self model imageRepository deleteImage: self model singleImage	
]

{ #category : #action }
PhLCreateTemplateFromImageAndRemoveImageCommand >> execute [
	self createTemplate.
	"remove image without confirmation"
	self deleteImage
]
