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
