"
Rename the selected template
"
Class {
	#name : #PhLRenameTemplateCommand,
	#superclass : #PhLTemplateCommand,
	#instVars : [
		'newImageName'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLRenameTemplateCommand class >> group [
	^ 2
]

{ #category : #accessing }
PhLRenameTemplateCommand class >> icon [
	^ self iconNamed: #workspace
]

{ #category : #accessing }
PhLRenameTemplateCommand class >> title [
	^ 'Rename template'
]

{ #category : #action }
PhLRenameTemplateCommand >> execute [
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (self model isNewLocalTemplateNameValid: name).
	self model singleTemplate renameTo: name.
	self model templateRepositoryChanged
]

{ #category : #testing }
PhLRenameTemplateCommand >> isApplicable [
	^ super isApplicable and: [ self model hasSingleLocalTemplateSelected ]
]

{ #category : #accessing }
PhLRenameTemplateCommand >> newImageName [
	^ newImageName ifNil: [ newImageName := self model requestNewImageName: self model singleTemplateName ]
]
