Class {
	#name : 'PhLImageBisectCliCommandTest',
	#superclass : 'PhLImageCliCommandTest',
	#instVars : [
		'outputStream'
	],
	#category : 'PharoLauncher-CLI-Tests',
	#package : 'PharoLauncher-CLI-Tests'
}

{ #category : 'running' }
PhLImageBisectCliCommandTest >> setUp [

	super setUp.
	outputStream := ZnBufferedWriteStream on:
		                (ZnCharacterWriteStream on: ByteArray new writeStream).
	context pharoLauncherModel consoleInputRequest outputStream: outputStream.
]

{ #category : 'tests' }
PhLImageBisectCliCommandTest >> testCanAskfFirstKnownFaultyImage [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: '1'.
	command builds: #(1 3 4 7 9).
	
	answer := command askForFirstKnownFaultyImage.
	
	self assert: answer equals: 1
]

{ #category : 'tests' }
PhLImageBisectCliCommandTest >> testCanAskfLastKnownCorrectImage [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: '1'.
	command builds: #(1 3 4 7 9).
	
	answer := command askForLastKnownCorrectImage.
	
	self assert: answer equals: 1
]

{ #category : 'tests' }
PhLImageBisectCliCommandTest >> testCanSpecifyPharoVersion [
	| command |
	context arguments: #( 'launcher' 'image' 'bisect' '--pharoVersion' '11').
	command := context command.
	
	self assert: command pharoVersion equals: 11
]

{ #category : 'tests' }
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

{ #category : 'tests' }
PhLImageBisectCliCommandTest >> testFirstKnownFaultyImageTakesLastBuildValueIfNoInput [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: ''.
	command builds: #(3 4 7 9).
	
	answer := command askForFirstKnownFaultyImage.
	
	self assert: answer equals: 9
]

{ #category : 'tests' }
PhLImageBisectCliCommandTest >> testGetPharoDevVersionWhenNoVersionSpecified [
	| devTemplate |
	self launcherModel
		templateRepository: PhLTemplateTestRepository new.
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	self addTemplateNamed: 'Pharo 9 64bit stable' inCategory: self defaultTemplateCategoryName.
	devTemplate := self addTemplateNamed: 'Pharo 10 64bit (development version, latest)' inCategory: self defaultTemplateCategoryName.
	devTemplate setName: devTemplate name url: 'https://files.pharo.org/image/100/latest-64.zip' asZnUrl.
	
	context arguments: #( 'launcher' 'image' 'bisect' ).

	self
		assert: context command pharoVersion
		equals: '10'
]

{ #category : 'tests' }
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

{ #category : 'tests' }
PhLImageBisectCliCommandTest >> testLastKnownCorrectImageTakesFirstBuildValueIfNoInput [
	| answer command |
	context arguments: #( 'launcher' 'image' 'bisect' ).
	command := context command.
	self addInputAnswer: ''.
	command builds: #(3 4 7 9).
	
	answer := command askForLastKnownCorrectImage.
	
	self assert: answer equals: 3
]
