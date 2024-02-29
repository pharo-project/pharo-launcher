"
I allow testing of code using a ConsoleInputRequest.
I mock user interactions.
You can give me predefined answers for given questions.
"
Class {
	#name : #ConsoleInputRequestMock,
	#superclass : #ConsoleInputRequest,
	#instVars : [
		'predefinedAnswers',
		'answerIndex'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
ConsoleInputRequestMock >> addAnswer: anAnswer [

	predefinedAnswers add: anAnswer
]

{ #category : #accessing }
ConsoleInputRequestMock >> answerIndex [

	answerIndex := answerIndex + 1.
	^ answerIndex.
]

{ #category : #initialization }
ConsoleInputRequestMock >> initialize [ 

	super initialize.
	predefinedAnswers := OrderedCollection new.
	answerIndex := 0
]

{ #category : #adding }
ConsoleInputRequestMock >> nbInputAnswerRead [
	^ answerIndex
]

{ #category : #accessing }
ConsoleInputRequestMock >> outputStream: aWriteStream [

	outputStream := aWriteStream
]

{ #category : #accessing }
ConsoleInputRequestMock >> readAnswer [

	^ predefinedAnswers at: self answerIndex.
]
