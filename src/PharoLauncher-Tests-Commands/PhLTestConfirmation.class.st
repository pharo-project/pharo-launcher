"
Mock for a user confirmation interaction
"
Class {
	#name : #PhLTestConfirmation,
	#superclass : #Object,
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
PhLTestConfirmation >> message: aString [ 
	self noop
]

{ #category : #private }
PhLTestConfirmation >> noop [
	"nothing to do"
]

{ #category : #accessing }
PhLTestConfirmation >> parentWindow: aWindowPresenter [ 
	"no need to keep the parent"
]
