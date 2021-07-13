"
A ""fake"" repository only usefull for the tests
"
Class {
	#name : #PhLImagesMockRepo,
	#superclass : #Object,
	#instVars : [
		'images'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLImagesMockRepo >> addImageNamed: anImageName [ 
	| image |
	image := PhLImagesMock name: anImageName.
	self images add: image.
	^ image
]

{ #category : #accessing }
PhLImagesMockRepo >> copyImage: anImageToCopy to: anImageCopy [
  (self images anySatisfy: [:image | image name =anImageCopy ]) ifTrue:[PhLNameNotAvailableError signalName: 'Name already used' ].
  self addImageNamed: anImageCopy
]

{ #category : #accessing }
PhLImagesMockRepo >> deleteImage: anImageName [
	self images remove: anImageName 
]

{ #category : #'test methods' }
PhLImagesMockRepo >> extractTemplate: aPhLRemoteTemplate to: anImageName [
	| imageTest |
	imageTest := PhLImagesMock name: anImageName.
	images add: imageTest
]

{ #category : #accessing }
PhLImagesMockRepo >> imageNamed: lowercaseImageName [
	^ self images
		detect: [ :image | image name asLowercase = lowercaseImageName ]
]

{ #category : #accessing }
PhLImagesMockRepo >> images [
   ^ images


]

{ #category : #accessing }
PhLImagesMockRepo >> images: aListOfImageMock [
	images := aListOfImageMock
]

{ #category : #accessing }
PhLImagesMockRepo >> imagesName [
	^ (self images collect: [ :each | each name ]) asSet
]

{ #category : #accessing }
PhLImagesMockRepo >> initialize [
	super initialize.
	images := OrderedCollection new
]
