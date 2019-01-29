Class {
	#name : #PhLMemoryImageRepository,
	#superclass : #Object,
	#instVars : [
		'images'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #adding }
PhLMemoryImageRepository >> addImage: aPhLImage [ 
	
	images add: aPhLImage
]

{ #category : #accessing }
PhLMemoryImageRepository >> images [
	^ images
]

{ #category : #initialization }
PhLMemoryImageRepository >> initialize [

	super initialize.
	images := OrderedCollection new.
]
