"
Mock for a user request interaction
"
Class {
	#name : 'PhLTestRequest',
	#superclass : 'Object',
	#instVars : [
		'validationBlock',
		'answer'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLTestRequest >> answer [
	^ answer
]

{ #category : 'accessing' }
PhLTestRequest >> answer: anObject [
	answer := anObject
]

{ #category : 'accessing' }
PhLTestRequest >> chooseFile [
	^ answer
]

{ #category : 'accessing' }
PhLTestRequest >> chooseFrom: aCollection [ 
	^ 1
]

{ #category : 'noop' }
PhLTestRequest >> currentFolder: aFileLocator [ 
	"noop"
]

{ #category : 'noop' }
PhLTestRequest >> filter: aFilterString [ 
	"noop"
]

{ #category : 'accessing' }
PhLTestRequest >> initialAnswer: aString [ 
	self noop
]

{ #category : 'accessing' }
PhLTestRequest >> label: aString [ 
	self noop
]

{ #category : 'private' }
PhLTestRequest >> noop [
	"do nothing"
]

{ #category : 'accessing' }
PhLTestRequest >> parentWindow: aWindowPresenter [ 
	"no need to keep the parent"
]

{ #category : 'accessing' }
PhLTestRequest >> request [
	^ (validationBlock value: self answer)
		ifTrue: [ self answer ]
		ifFalse: [ nil ]
]

{ #category : 'accessing' }
PhLTestRequest >> title: aString [ 
	self noop
]

{ #category : 'accessing' }
PhLTestRequest >> validateAnswer: aBlock [
	validationBlock := aBlock
]
