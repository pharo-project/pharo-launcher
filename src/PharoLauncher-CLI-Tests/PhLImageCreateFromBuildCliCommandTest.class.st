Class {
	#name : #PhLImageCreateFromBuildCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildOfATemplateShouldSucceed [
	| command |
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	command := (context arguments: #('launcher' 'image' 'create' 'fromBuild' '18' '--newImageName' 'myImage3'  '--pharoVersion' '10')) command.
	command imageFinderClass: PhLImageFinderStub.
	command execute.
	self assert: self errorString isEmpty.
	self assert: (self outputString includesSubstring: 'Pharo10-SNAPSHOT.build.18').
	self assert: self imageRepository imagesName equals: #('myImage1' 'myImage3' 'myImage2') asSet
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildIsMissing [
	
	self runCommand: #('launcher' 'image' 'create' 'fromBuild' '--pharoVersion' '10').
	self assertFailure.
	"standard err stream should include error message for missing build number ."
	self assert: (self errorString includesSubstring: 'specify the Pharo build number').
		
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildNrDoesNotExist [

	| command |
	command := (context arguments: #('launcher' 'image' 'create' 'fromBuild' '157865156' '--pharoVersion' '10')) command.
	command imageFinderClass: PhLImageFinderStub.
	self should: [command basicExecute] raise: PhLDownloadError whoseDescriptionIncludes: 'Could not determine remote image template from build number' description: 'Error is expected when trying to get non-existent build artifact'.

	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildNrIsInvalid [
	
	self runCommand: #('launcher' 'image' 'create' 'fromBuild' 'NotANumber' '--pharoVersion' '10').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Not a valid build number').
	self assert: self imageRepository imagesName equals: Set empty
]
