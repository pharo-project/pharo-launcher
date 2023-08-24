"
Mock for a user confirmation interaction
"
Class {
	#name : #PhLTestConfirmation,
	#superclass : #Object,
	#instVars : [
		'message'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #action }
PhLTestConfirmation >> confirm [
	^ true
]

{ #category : #action }
PhLTestConfirmation >> inform [
	self noop 
]

{ #category : #accessing }
PhLTestConfirmation >> message [
	^ message
]

{ #category : #accessing }
PhLTestConfirmation >> message: aString [ 
	message := aString
]

{ #category : #private }
PhLTestConfirmation >> noop [
	"nothing to do"
]

{ #category : #accessing }
PhLTestConfirmation >> parentWindow: aWindowPresenter [ 
	"no need to keep the parent"
]
