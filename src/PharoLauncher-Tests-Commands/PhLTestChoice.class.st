"
Mock for a user choice interaction
"
Class {
	#name : 'PhLTestChoice',
	#superclass : 'Object',
	#instVars : [
		'items',
		'answerIndex'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLTestChoice >> answerIndex: anIndex [
	"The index of the item chosen by the user. Nil to cancel"

	answerIndex := anIndex
]

{ #category : 'accessing' }
PhLTestChoice >> items: aCollection [
	items := aCollection
]

{ #category : 'accessing' }
PhLTestChoice >> message: aString [
	"noop"
]

{ #category : 'accessing' }
PhLTestChoice >> run [
	"As the real choice, answer the chosen item or nil if cancelled"

	^ answerIndex ifNotNil: [ items at: answerIndex ]
]

{ #category : 'accessing' }
PhLTestChoice >> title: aString [
	"noop"
]
