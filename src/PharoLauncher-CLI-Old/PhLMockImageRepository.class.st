"
Usefull only to run the tests. Indeed each users have not the same Images on their drive so we create a ""fake directory"" containing fake ""images"" on prder to always have the same tests.
"
Class {
	#name : #PhLMockImageRepository,
	#superclass : #Object,
	#instVars : [
		'images'
	],
	#category : #'PharoLauncher-CLI-Old-PharoLauncher-CLI-Old'
}

{ #category : #instance }
PhLMockImageRepository >> add: aString [ 
	self images add: aString.
]

{ #category : #accessing }
PhLMockImageRepository >> images [
   ^ images
]

{ #category : #accessing }
PhLMockImageRepository >> images: anOrderedCollectionContainingImagesAdresses [
   images := anOrderedCollectionContainingImagesAdresses.
]
