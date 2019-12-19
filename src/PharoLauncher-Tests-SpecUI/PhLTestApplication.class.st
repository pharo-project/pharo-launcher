"
A spec application used for test purposes.
I can answer pre-arranged responses to UI requests.
"
Class {
	#name : #PhLTestApplication,
	#superclass : #SpApplication,
	#instVars : [
		'requestAnswer'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #request }
PhLTestApplication >> newRequest [
	"do nothing"
]

{ #category : #request }
PhLTestApplication >> request [
	^ requestAnswer
]

{ #category : #accessing }
PhLTestApplication >> requestAnswer: aString [
	requestAnswer := aString
]

{ #category : #request }
PhLTestApplication >> title: aString [ 
	"do nothing"
]

{ #category : #request }
PhLTestApplication >> validateAnswer: aBlockClosure [ 
	"do nothing"
]
