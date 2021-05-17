"
A ""fake"" repository only usefull for the tests
"
Class {
	#name : #PhLImagesMockRepo,
	#superclass : #Object,
	#instVars : [
		'images'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #accessing }
PhLImagesMockRepo >> add: aString [ 
	self images add: aString.
]

{ #category : #accessing }
PhLImagesMockRepo >> copyImage: anImageToCopy to: anImageCopy [
 
  | copy | 
   
  copy := PhLImagesMock name: anImageCopy.
  
  self add: copy.
]

{ #category : #accessing }
PhLImagesMockRepo >> deleteImage: anImageName [
  self images remove: anImageName ifAbsent:[^0] 
]

{ #category : #'test methods' }
PhLImagesMockRepo >> extractTemplate: aPhLRemoteTemplate to: aString [ 
   | imageTest |
   imageTest := PhLImagesMock name:aString.
	images add: imageTest.
]

{ #category : #accessing }
PhLImagesMockRepo >> images [
   ^ images


]

{ #category : #accessing }
PhLImagesMockRepo >> images: anOrderedCollectionContainingImagesAdresses [
   images := anOrderedCollectionContainingImagesAdresses.
]

{ #category : #accessing }
PhLImagesMockRepo >> initialize [ 
   super initialize. 
   images := OrderedCollection new.
]
