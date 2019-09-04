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

{ #category : #'as yet unclassified' }
PhLTestRequest >> initialAnswer: aString [ 
	self noop
]

{ #category : #private }
PhLTestRequest >> noop [
	"do nothing"
]

{ #category : #'as yet unclassified' }
PhLTestRequest >> request [
	^ (validationBlock value: self answer)
		ifTrue: [ self answer ]
		ifFalse: [ nil ]
]

{ #category : #noop }
PhLTestRequest >> title: aString [ 
	self noop
]

{ #category : #'as yet unclassified' }
PhLTestRequest >> validateAnswer: aBlock [
	validationBlock := aBlock
]
