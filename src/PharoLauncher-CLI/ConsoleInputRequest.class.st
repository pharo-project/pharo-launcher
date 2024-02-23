"
I'm a simple object you can use to ask a question on command line and get back the answer.
The current process will be blocked until there is some data provided on the command line followed by the <enter> key.

WARNING: the user could type some data before waiting for it but this data will be part of the user anwer as weel as the characters typed after the waiting.

## Example

```language=Pharo
	answer := (ConsoleInputRequest inputStream: Stdio stdin outputStream: Stdio stdout)
		question: 'Are you sure you want to remove this image? [y-n]';
		answer.
```
"
Class {
	#name : #ConsoleInputRequest,
	#superclass : #Object,
	#instVars : [
		'inputStream',
		'outputStream',
		'question',
		'validationBlock',
		'transformBlock',
		'answer',
		'validationErrorMessage'
	],
	#category : #'PharoLauncher-CLI-Utility'
}

{ #category : #'instance creation' }
ConsoleInputRequest class >> inputStream: inStream outputStream: outStream [

	^ self new
		inputStream: inStream outputStream: outStream;
		yourself
]

{ #category : #accessing }
ConsoleInputRequest >> answer [ 
	
	| isValid validatedAnswer |
	isValid := false.
	[ [ isValid := self oneAnswerCycle ]
		on: Error
		do: [ :error | self logError: error ] ]
	doWhileFalse: [ isValid ].
	
	validatedAnswer := answer.
	self reset.
	^ validatedAnswer
]

{ #category : #private }
ConsoleInputRequest >> askQuestion [

	outputStream 
		nextPutAll: question;
		nextPut: Character space;
		flush.
]

{ #category : #initialization }
ConsoleInputRequest >> inputStream: inStream outputStream: outStream [

	inputStream := inStream.

	outputStream := ZnBufferedWriteStream on:
		                (ZnCharacterWriteStream on: outStream)
]

{ #category : #private }
ConsoleInputRequest >> logError: error [

	outputStream nextPutAll: 'Invalid answer. '.
	validationErrorMessage ifNotNil: [ outputStream nextPutAll: validationErrorMessage ].
	outputStream lf
		 
]

{ #category : #private }
ConsoleInputRequest >> oneAnswerCycle [
	
	self askQuestion.
	answer := self readAnswer.
	transformBlock ifNotNil: [ answer := transformBlock value: answer ].
	validationBlock ifNil: [ ^ true ].
	^ validationBlock value: answer
]

{ #category : #accessing }
ConsoleInputRequest >> question: aString [

	question := aString
]

{ #category : #private }
ConsoleInputRequest >> readAnswer [
	
	inputStream waitForData.
	inputStream releaseSemaphores.
	^ (ZnFastLineReader on: (
			ZnCharacterReadStream on: (
				ZnBufferedReadStream on: inputStream) )) nextLine
]

{ #category : #initialization }
ConsoleInputRequest >> reset [

	question := nil.
	transformBlock := nil.
	validationBlock := nil.
	validationErrorMessage := nil.
	answer := nil
]

{ #category : #accessing }
ConsoleInputRequest >> transform: aBlock [
	
	transformBlock := aBlock
]

{ #category : #configuring }
ConsoleInputRequest >> useShortYesNoValidation [
	" [y|n] "

	self validation: [ :aString |
		aString size = 1 and: [
			aString first asLowercase = $y or: [ aString first asLowercase = $n ] ] ].
	self validationErrorMessage: 'Please provide a valid answer: y or n'
]

{ #category : #accessing }
ConsoleInputRequest >> validation: aBlock [
	
	validationBlock := aBlock
]

{ #category : #accessing }
ConsoleInputRequest >> validationErrorMessage: aString [

	validationErrorMessage := aString
]
