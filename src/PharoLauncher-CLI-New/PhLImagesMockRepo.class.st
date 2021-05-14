Class {
	#name : #PhLImagesMockRepo,
	#superclass : #Object,
	#instVars : [
		'images'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #accessing }
PhLImagesMockRepo >> images [
   ^ images
]

{ #category : #accessing }
PhLImagesMockRepo >> images: anOrderedCollectionContainingImagesAdresses [
   images := anOrderedCollectionContainingImagesAdresses.
]
