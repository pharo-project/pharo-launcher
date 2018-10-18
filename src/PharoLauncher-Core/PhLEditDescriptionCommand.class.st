"
Edit the description of an image
"
Class {
	#name : #PhLEditDescriptionCommand,
	#superclass : #PhLImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLEditDescriptionCommand class >> group [
	^ 3
]

{ #category : #accessing }
PhLEditDescriptionCommand class >> icon [
	^ self iconNamed: #editIcon
]

{ #category : #accessing }
PhLEditDescriptionCommand class >> title [
	^ 'Edit image description'
]

{ #category : #action }
PhLEditDescriptionCommand >> execute [
	| description |
	description := self imageDescription.
	description := UIManager default
		multiLineRequest: 'Description of the image'
		initialAnswer: description
		answerHeight: 200.
	description ifNil: [ ^ self ].	"Edition cancelled"
	self imageDescription: description
]

{ #category : #accessing }
PhLEditDescriptionCommand >> imageDescription [
	| description |
	[ self imageDescriptionFile
		readStreamDo: [ :stream | description := stream contents ] ]
		on: Error
		do: [ description := '' ].
	^ description
]

{ #category : #accessing }
PhLEditDescriptionCommand >> imageDescription: description [
	self imageDescriptionFile
		writeStreamDo: [ :stream | stream nextPutAll: description ]
]

{ #category : #accessing }
PhLEditDescriptionCommand >> imageDescriptionFile [
	^ self model singleImage imageFile parent / 'description.txt'
]
