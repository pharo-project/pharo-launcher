"
Mock for a user request interaction
"
Class {
	#name : #PhLTestRequest,
	#superclass : #Object,
	#instVars : [
		'validationBlock',
		'answer'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #accessing }
PhLTestRequest >> answer [
	^ answer
]

{ #category : #accessing }
PhLTestRequest >> answer: anObject [
	answer := anObject
]

{ #category : #accessing }
PhLTestRequest >> chooseFile [
	^ answer
]

{ #category : #accessing }
PhLTestRequest >> chooseFrom: aCollection [ 
	^ 1
]

{ #category : #noop }
PhLTestRequest >> extensionsToShow: aCollection [ 
	"noop"
]

{ #category : #accessing }
PhLTestRequest >> initialAnswer: aString [ 
	self noop
]

{ #category : #private }
PhLTestRequest >> noop [
	"do nothing"
]

{ #category : #accessing }
PhLTestRequest >> parentWindow: aWindowPresenter [ 
	"no need to keep the parent"
]

{ #category : #noop }
PhLTestRequest >> path: aFileLocator [ 
	"noop"
]

{ #category : #accessing }
PhLTestRequest >> request [
	^ (validationBlock value: self answer)
		ifTrue: [ self answer ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
PhLTestRequest >> title: aString [ 
	self noop
]

{ #category : #accessing }
PhLTestRequest >> validateAnswer: aBlock [
	validationBlock := aBlock
]
