"
Mock for a user confirmation interaction
"
Class {
	#name : 'PhLTestConfirmation',
	#superclass : 'Object',
	#instVars : [
		'answer',
		'message',
		'title'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLTestConfirmation >> answer: aBoolean [
	answer := aBoolean
]

{ #category : 'action' }
PhLTestConfirmation >> confirm [
	^ answer ifNil: [ true ]
]

{ #category : 'action' }
PhLTestConfirmation >> inform [
	self noop 
]

{ #category : 'accessing' }
PhLTestConfirmation >> message [
	^ message
]

{ #category : 'accessing' }
PhLTestConfirmation >> message: aString [ 
	message := aString
]

{ #category : 'private' }
PhLTestConfirmation >> noop [
	"nothing to do"
]

{ #category : 'accessing' }
PhLTestConfirmation >> parentWindow: aWindowPresenter [ 
	"no need to keep the parent"
]

{ #category : 'accessing' }
PhLTestConfirmation >> title: aString [ 
	title := aString
]
