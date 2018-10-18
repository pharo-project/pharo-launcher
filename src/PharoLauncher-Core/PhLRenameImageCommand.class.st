"
Rename the currently selected image and move the files accordingly.
"
Class {
	#name : #PhLRenameImageCommand,
	#superclass : #PhLImageCommand,
	#instVars : [
		'newImageName'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLRenameImageCommand class >> icon [
	^ self iconNamed: #workspaceIcon
]

{ #category : #accessing }
PhLRenameImageCommand class >> title [
	^ 'Rename'
]

{ #category : #action }
PhLRenameImageCommand >> execute [
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (self model isNewImageNameValid: name).
	self model imageRepository renameImage: self model singleImage to: name
]

{ #category : #accessing }
PhLRenameImageCommand >> newImageName [
	^ newImageName ifNil: [ newImageName := self model requestNewImageName: self model singleImageName ]
]
