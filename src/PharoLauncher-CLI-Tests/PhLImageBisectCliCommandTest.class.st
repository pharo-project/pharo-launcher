Class {
	#name : #PhLImageBisectCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'outputStream'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #running }
PhLImageBisectCliCommandTest >> setUp [

	super setUp.
	outputStream := ZnBufferedWriteStream on:
		                (ZnCharacterWriteStream on: ByteArray new writeStream).
	context pharoLauncherModel consoleInputRequest outputStream: outputStream.
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testCanAskfFirstKnownFaultyImage [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: '1'.
	command builds: #(1 3 4 7 9).
	
	answer := command askForFirstKnownFaultyImage.
	
	self assert: answer equals: 1
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testCanAskfLastKnownCorrectImage [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: '1'.
	command builds: #(1 3 4 7 9).
	
	answer := command askForLastKnownCorrectImage.
	
	self assert: answer equals: 1
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testCanSpecifyPharoVersion [
	| command |
	context arguments: #( 'launcher' 'image' 'bisect' '--pharoVersion' '11').
	command := context command.
	
	self assert: command pharoVersion equals: 11
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testFirstKnownFaultyImageOnlyAcceptsValuesFromBuildValues [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: '2'.
	self addInputAnswer: '1'.
	command builds: #(1 3 4 7 9).
	
	answer := command askForFirstKnownFaultyImage.
	
	self assert: answer equals: 1.
	self assert: self nbInputAnswerRead equals: 2
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testFirstKnownFaultyImageTakesLastBuildValueIfNoInput [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: ''.
	command builds: #(3 4 7 9).
	
	answer := command askForFirstKnownFaultyImage.
	
	self assert: answer equals: 9
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testGetPharoDevVersionWhenNoVersionSpecified [

	context arguments: #( 'launcher' 'image' 'bisect' ).

	self
		assert: context command pharoVersion
		equals: (SystemVersion current major + 1) asString
	"Pharo Launcher is based on the latest Pharo stable but we should find a way to control template sources in a test context"
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testLastKnownCorrectImageOnlyAcceptsValuesFromBuildValues [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: '2'.
	self addInputAnswer: '1'.
	command builds: #(1 3 4 7 9).
	
	answer := command askForLastKnownCorrectImage.
	
	self assert: answer equals: 1.
	self assert: self nbInputAnswerRead equals: 2
]

{ #category : #tests }
PhLImageBisectCliCommandTest >> testLastKnownCorrectImageTakesFirstBuildValueIfNoInput [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: ''.
	command builds: #(3 4 7 9).
	
	answer := command askForLastKnownCorrectImage.
	
	self assert: answer equals: 3
]
