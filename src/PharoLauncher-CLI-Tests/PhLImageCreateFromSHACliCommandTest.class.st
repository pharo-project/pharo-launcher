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
	self assert: (self errorString includesSubstring: 'Please specify the commit SHA string to find the image template').
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromSHACliCommandTest >> testCreateImageFromShaShouldFailWhenShaDoesNotExist [
	| command |
	command := (context arguments: #('launcher' 'image' 'create' 'fromSHA' 'NotASha' '--pharoVersion' '10')) command.
	command imageFinderClass: PhLImageFinderStub.
	self should: [command basicExecute] raise: PhLDownloadError whoseDescriptionIncludes: 'Could not determine remote image template from SHA' description: 'Error is expected when trying to get non-existent SHA'.
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
	| command |
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	command := (context arguments: #('launcher' 'image' 'create' 'fromSHA' '06373fd' '--newImageName' 'myImage3'  '--pharoVersion' '10')) command.
	command imageFinderClass: PhLImageFinderStub.
	command basicExecute.
	self assert: self imageRepository imagesName equals: #('myImage1' 'myImage3' 'myImage2') asSet
]
