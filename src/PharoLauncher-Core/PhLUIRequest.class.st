"
Abstraction of a string request dialog.
"
Class {
	#name : #PhLUIRequest,
	#superclass : #PhLUserInteraction,
	#instVars : [
		'title',
		'initialAnswer',
		'validationBlock'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLUIRequest >> initialAnswer: aString [ 
	initialAnswer := aString
]

{ #category : #action }
PhLUIRequest >> request [
	| answer |
	[ answer := UIManager default request: title initialAnswer: initialAnswer ]
		doWhileTrue: [ answer isNotNil and: [ (validationBlock value: answer) not ] ].
		"answer is nil when the user press cancels. That's a possible answer we have to accept."
	^ answer
]

{ #category : #accessing }
PhLUIRequest >> title: aString [ 
	title := aString
]

{ #category : #accessing }
PhLUIRequest >> validateAnswer: aBlock [
	validationBlock := aBlock
]
