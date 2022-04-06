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
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLUIRequest >> chooseFrom: aListOfChoices [

	^ self application newSelect 
		title: title;
		items: aListOfChoices;
		openModalWithParent: self relatedWindow
]

{ #category : #accessing }
PhLUIRequest >> initialAnswer: aString [

	initialAnswer := aString
]

{ #category : #action }
PhLUIRequest >> request [
	| answer |
	
	[ 
		answer := self application newRequest
			title: title; 
			text: initialAnswer;
			openModalWithParent: self relatedWindow ] 
	doWhileTrue: [ 
		answer isNotNil 
			and: [ validationBlock isNotNil 
			and: [ (validationBlock value: answer) not ] ] ].

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
