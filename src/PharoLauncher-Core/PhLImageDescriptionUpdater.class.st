"
I'm used to update and by so, serialize the image description to disk.
I implement a mechanism to delay the saving by a few seconds to avoid too much disk i/o.
Indeed, If I'm asked to update many times within a short delay, I will abort the current saving and replace it by the new one. It can be used to update the description at each text change in the UI.
"
Class {
	#name : #PhLImageDescriptionUpdater,
	#superclass : #Object,
	#instVars : [
		'image',
		'description',
		'process',
		'saveBlock'
	],
	#classInstVars : [
		'Default'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLImageDescriptionUpdater class >> default [ 
	^ Default ifNil: [ Default := self new ]
]

{ #category : #'instance creation' }
PhLImageDescriptionUpdater class >> image: aPhLImage description: aString [
	^ self default 
		image: aPhLImage description: aString;
		yourself
]

{ #category : #initialization }
PhLImageDescriptionUpdater class >> reset [ 
	Default := nil.
]

{ #category : #saving }
PhLImageDescriptionUpdater >> doSave [
	"Will trigger the write of metadata on disk"
	image description: description
]

{ #category : #initialization }
PhLImageDescriptionUpdater >> image: aPhLImage description: aString [
	(aPhLImage isNil or: [ aPhLImage location = '' ]) ifTrue: [ ^ self ].
	
	self terminateProcess.
	"image changed, no more edition of description, save it without delay"	
	(image isNotNil and: [ image file path ~= aPhLImage file path ])
		ifTrue: [ self doSave ].
		
	image := aPhLImage.
	description := aString.
	image description = description 
		ifFalse: [ self newProcess ].
]

{ #category : #private }
PhLImageDescriptionUpdater >> newProcess [
	process := 
		[ self waitDelay wait. "Avoid to save description at each key stroke"
		self doSave ] 
			forkNamed: 'Pharo Launcher image description save process'.
]

{ #category : #private }
PhLImageDescriptionUpdater >> terminateProcess [ 
	process ifNotNil: [ process terminate ]
]

{ #category : #accessing }
PhLImageDescriptionUpdater >> waitDelay [
	^ 3 seconds
]
