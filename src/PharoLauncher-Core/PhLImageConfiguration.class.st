"
I am a launch configuration that knows how to launch an image.
I have all the required information to run one:
 - vm
 - arguments
 - use settings

An image stores many of my instances so the user can choose one to launche it.
"
Class {
	#name : #PhLImageConfiguration,
	#superclass : #PhLObject,
	#instVars : [
		'name',
		'vm',
		'image',
		'imageArguments'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLImageConfiguration class >> defaultWithImage: anImage [

	^ (self withImage: anImage)
		name: 'Default';
		yourself
]

{ #category : #accessing }
PhLImageConfiguration class >> withImage: anImage [

	^ self new
		initializeWithImage: anImage;
		yourself
]

{ #category : #accessing }
PhLImageConfiguration >> imageArguments [
	^ imageArguments
]

{ #category : #accessing }
PhLImageConfiguration >> imageArguments: aString [
	
	imageArguments := aString
]

{ #category : #accessing }
PhLImageConfiguration >> initializeWithImage: anImage [

	self initialize.
	image := anImage.
	name := 'new configuration...'.
	vm := PhLDefaultVM image: image.
	imageArguments := ''
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
PhLImageConfiguration >> useSettings [
	
	^ true
]

{ #category : #accessing }
PhLImageConfiguration >> vm [
	
	^ vm
]

{ #category : #accessing }
PhLImageConfiguration >> vm: aVM [ 
	vm := aVM
]
