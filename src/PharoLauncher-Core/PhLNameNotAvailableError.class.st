"
Error raised when the name provided is not available.
e.g. trying to create an image with the same name as an existing Pharo image
"
Class {
	#name : #PhLNameNotAvailableError,
	#superclass : #PhLError,
	#instVars : [
		'providedName'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #signalling }
PhLNameNotAvailableError class >> signalName: aString [
	^ self new
		setProvidedName: aString;
		signal
]

{ #category : #accessing }
PhLNameNotAvailableError >> longDescription [
	^ 'Provided name {1} is not available!' format: self providedName
]

{ #category : #accessing }
PhLNameNotAvailableError >> name [
	^ 'Name error'
]

{ #category : #initialization }
PhLNameNotAvailableError >> providedName [
	^ providedName
]

{ #category : #initialization }
PhLNameNotAvailableError >> setProvidedName: aString [
	providedName := aString
]
