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
	
	self should:
	[	self runCommand: #('launcher' 'image' 'create' 'fromSHA' '--pharoVersion' '10').
	] raise: NotFound.
	"TODO - test for error message occurence, when exception is handled in execute"
	"self assert: (self errorString includesSubstring: PhLImageCreateFromBuildCliCommand missingShaArgMessage)."
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromSHACliCommandTest >> testCreateImageFromShaShouldFailWhenShaDoesNotExist [
	
	self should:
	[ 
		self runCommand: #('launcher' 'image' 'create' 'fromSHA' 'NotASha' '--pharoVersion' '10').
	] raise: PhLDownloadError.
	"TODO - test for error string occurence in error output once Exceptions are handled"
	"self assert: (self errorString includesSubstring: PhLImageCreateFromShaCliCommand cantFindImageTemplateMessage)."
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromSHACliCommandTest >> testCreateImageFromShaShouldFailWhenShaIsInvalid [
	
	self should:
	[ 
		self runCommand: #('launcher' 'image' 'create' 'fromSHA' 'NotAValidSha' '--pharoVersion' '10').
	] raise: Error.
	"TODO - test for error string occurence in error output once Exceptions are handled"
	"self assert: (self errorString includesSubstring: PhLImageCreateFromShaCliCommand missingShaMessage)."
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
