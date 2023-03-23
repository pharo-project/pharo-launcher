"
A PhLImageCreateFromSHACliCommandTest is a test class for testing the behavior of PhLImageCreateFromSHACliCommand
"
Class {
	#name : #PhLImageCreateFromSHACliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromSHACliCommandTest >> testCreateImageFromABuildShouldFailWhenShaIsMissing [
	
	self runCommand: #('launcher' 'image' 'create' 'fromSHA' '--pharoVersion' '10').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Cannot find sha').
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromSHACliCommandTest >> testCreateImageFromShaShouldFailWhenShaDoesNotExist [
	
	self runCommand: #('launcher' 'image' 'create' 'fromSHA' 'NotASha' '--pharoVersion' '10').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Could not determine remote image template from SHA').
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromSHACliCommandTest >> testCreateImageFromShaShouldFailWhenShaIsInvalid [
	
	self runCommand: #('launcher' 'image' 'create' 'fromSHA' 'NotAValidSha' '--pharoVersion' '10').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Not a valid sha string').
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromSHACliCommandTest >> testCreateImageFromShaShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'create' 'fromSHA' '68bad00' '--newImageName' 'myImage3'  '--pharoVersion' '10').
	
	self assertSuccess.
	self assert: self imageRepository imagesName equals: #('myImage1' 'myImage3' 'myImage2') asSet
]
