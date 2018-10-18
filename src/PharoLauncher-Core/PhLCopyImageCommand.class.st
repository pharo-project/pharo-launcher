"
Copy one image to another name.
"
Class {
	#name : #PhLCopyImageCommand,
	#superclass : #PhLImageCommand,
	#instVars : [
		'newImageName'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLCopyImageCommand class >> icon [
	^ self iconNamed: #smallCopyIcon
]

{ #category : #accessing }
PhLCopyImageCommand class >> title [
	^ 'Copy'
]

{ #category : #action }
PhLCopyImageCommand >> execute [
	| name |
	name := self newImageName.
	name ifNil: [ ^ self ].
	self
		ensure: (self model isNewImageNameValid: name).
	self model imageRepository copyImage: self model singleImage to: name.
]

{ #category : #accessing }
PhLCopyImageCommand >> newImageName [
	^ newImageName ifNil: [ newImageName := self model requestNewImageName: self model singleImageName ]
]
