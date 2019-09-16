"
I am a non-resolved VM that will define how to open an image on demand.
My method #executablePath checks for the correct image to use when running from an image configuration and uses that image.
"
Class {
	#name : #PhLDefaultVM,
	#superclass : #Object,
	#instVars : [
		'image'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLDefaultVM class >> image: anImage [

	^ self new
		image: anImage;
		yourself
]

{ #category : #comparing }
PhLDefaultVM >> = aVM [

	^ aVM isDefaultVM
]

{ #category : #accessing }
PhLDefaultVM >> executablePath [

	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: image file pathString.
	image computePharoVersionWith: vmManager.
	^ vmManager vm
]

{ #category : #accessing }
PhLDefaultVM >> image [
	^ image
]

{ #category : #accessing }
PhLDefaultVM >> image: anObject [
	image := anObject
]

{ #category : #comparing }
PhLDefaultVM >> isDefaultVM [

	^ true
]

{ #category : #accessing }
PhLDefaultVM >> name [
	
	^ 'Default'
]
