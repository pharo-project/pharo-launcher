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
	self addImageNamed: anImageCopy
]

{ #category : #accessing }
PhLImagesMockRepo >> deleteImage: anImageName [
	self images remove: anImageName ifAbsent: [ ^ 0 ]
]

{ #category : #'test methods' }
PhLImagesMockRepo >> extractTemplate: aPhLRemoteTemplate to: aString [
	| imageTest |
	imageTest := PhLImagesMock name: aString.
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
PhLImagesMockRepo >> images: anOrderedCollectionContainingImagesAdresses [
	images := anOrderedCollectionContainingImagesAdresses
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
