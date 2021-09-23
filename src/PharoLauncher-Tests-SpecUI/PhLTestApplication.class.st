"
A spec application used for test purposes.
I can answer pre-arranged responses to UI requests.
"
Class {
	#name : #PhLTestApplication,
	#superclass : #SpApplication,
	#instVars : [
		'requestAnswer',
		'imagesPresenter'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #confirmation }
PhLTestApplication >> confirm [
	^ true
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLTestApplication >> imagesPresenter: aPhLImagesPresenter [
	imagesPresenter := aPhLImagesPresenter
]

{ #category : #request }
PhLTestApplication >> inform [
	"do nothing"
]

{ #category : #events }
PhLTestApplication >> launchConfigurationEdited: aPhLLaunchConfiguration [ 
	"do nothing"
]

{ #category : #confirmation }
PhLTestApplication >> message: aString [ 
	"do nothing"
]

{ #category : #confirmation }
PhLTestApplication >> newConfirm [
	"do nothing"
]

{ #category : #confirmation }
PhLTestApplication >> newConfirmation [
	"do nothing"
]

{ #category : #confirmation }
PhLTestApplication >> newInformation [
	"do nothing"
]

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
