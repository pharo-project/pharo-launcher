Class {
	#name : #ConsoleInputRequestTest,
	#superclass : #TestCase,
	#instVars : [
		'consoleInputRequest',
		'outputStream'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #accessing }
ConsoleInputRequestTest >> outputString [ 
	
	^ outputStream contents utf8Decoded
]

{ #category : #running }
ConsoleInputRequestTest >> setUp [
	super setUp.
	outputStream := ZnBufferedWriteStream on:
		                (ZnCharacterWriteStream on: ByteArray new writeStream).
	consoleInputRequest := ConsoleInputRequestMock inputStream: nil outputStream: outputStream.
]

{ #category : #tests }
ConsoleInputRequestTest >> testCanRequestSimpleValue [

	| name question |
	name := 'joe'.
	question := 'What''s your name?'.
	consoleInputRequest 
		question: question;
		addAnswer: name.
	
	self assert: consoleInputRequest answer equals: name.
	self assert: self outputString equals: question, ' '
]

{ #category : #tests }
ConsoleInputRequestTest >> testCanReuseInstanceAfterGettingAnswer [

	| name question |

	question := 'How old are you?'.
	consoleInputRequest 
		question: question;
		transform: [ :s | Integer readFrom: s ];
		addAnswer: '21'.
	
	self assert: consoleInputRequest answer equals: 21.

	name := 'jane'.
	question := 'What is your name?'.
	consoleInputRequest 
		question: question;
		addAnswer: name.

	self assert: consoleInputRequest answer equals: name.

]

{ #category : #tests }
ConsoleInputRequestTest >> testGet2InputRequestIfFirstAnswerIsNotValid [

	| name question |
	name := 'joe'.
	question := 'What is your name?'.
	consoleInputRequest 
		question: question;
		validation: [ :answer | answer trim isNotEmpty ];
		addAnswer: '';
		addAnswer: name.
	
	self assert: consoleInputRequest answer equals: name.
	self assert: self outputString equals: question , ' ', question, ' '
]

{ #category : #tests }
ConsoleInputRequestTest >> testGet2InputRequestIfFirstAnswerTriggeredErrorDuringTransform [

	| question |
	question := 'Give me a number:'.
	consoleInputRequest 
		question: question;
		transform: [ :answer | Integer readFrom: answer ];
		addAnswer: '';
		addAnswer: '8'.
	
	self assert: consoleInputRequest answer equals: 8.
	self assert: self outputString equals: question , ' ', 'Invalid answer. ', String lf, question, ' '
]

{ #category : #tests }
ConsoleInputRequestTest >> testGet2InputRequestIfFirstAnswerTriggeredErrorDuringValidation [

	| question |
	question := 'Give me a number:'.
	consoleInputRequest 
		question: question;
		validation: [ :answer | (Integer readFrom: answer) isInteger ];
		addAnswer: '';
		addAnswer: '8'.
	
	self assert: consoleInputRequest answer equals: '8'.
	self assert: self outputString equals: question , ' ', 'Invalid answer. ', String lf, question, ' '
]
