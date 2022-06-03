Class {
	#name : #PhLImageCreateFromBuildCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildOfATemplateShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'create' 'fromBuild' '18' '--newImageName' 'myImage3'  '--pharoVersion' '10').
	
	self assertSuccess.
	self assert: self imageRepository imagesName equals: #('myImage1' 'myImage3' 'myImage2') asSet
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildIsMissing [
	
	self should:
	[	self runCommand: #('launcher' 'image' 'create' 'fromBuild' '--pharoVersion' '10').
	] raise: NotFound.
	"TODO - test for error message occurence, when exception is handled in execute"
	"self assert: (self errorString includesSubstring: PhLImageCreateFromBuildCliCommand missingBuildNrArgMessage)."
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildNrDoesNotExist [
	
	self should:
	[ 
		self runCommand: #('launcher' 'image' 'create' 'fromBuild' '157865156' '--pharoVersion' '10').
	] raise: PhLDownloadError.
	"TODO - test for error string occurence in error output once Exceptions are handled"
	"self assert: (self errorString includesSubstring: PhLImageCreateFromBuildCliCommand cantFindImageTemplateMessage)."
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildNrIsInvalid [
	
	self should:
	[ 
		self runCommand: #('launcher' 'image' 'create' 'fromBuild' 'NotANumber' '--pharoVersion' '10').
	] raise: Error.
	"TODO - test for error string occurence in error output once Exceptions are handled"
	"self assert: (self errorString includesSubstring: PhLImageCreateFromBuildCliCommand missingOrDuplicatedBuildNumberOrShaMessage)."
	self assert: self imageRepository imagesName equals: Set empty
]
