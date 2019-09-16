Class {
	#name : #PhLImageConfiguration,
	#superclass : #PhLObject,
	#instVars : [
		'name',
		'vm',
		'image'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLImageConfiguration class >> defaultWithImage: anImage [

	^ (self withImage: anImage)
		name: 'default';
		yourself
]

{ #category : #accessing }
PhLImageConfiguration class >> withImage: anImage [

	^ self new
		initializeWithImage: anImage;
		yourself
]

{ #category : #accessing }
PhLImageConfiguration >> initializeWithImage: anImage [

	super initialize.
	image := anImage.
	name := 'new configuration...'.
	vm := PhLDefaultVM image: image
]

{ #category : #accessing }
PhLImageConfiguration >> name [
	
	^ name
]

{ #category : #accessing }
PhLImageConfiguration >> name: aString [ 
	name := aString
]

{ #category : #accessing }
PhLImageConfiguration >> vm [
	
	^ vm
]

{ #category : #accessing }
PhLImageConfiguration >> vm: aVM [ 
	vm := aVM
]
