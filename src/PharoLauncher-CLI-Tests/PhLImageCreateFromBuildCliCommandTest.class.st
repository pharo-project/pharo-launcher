Class {
	#name : #PhLImageCreateFromBuildCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildOfATemplateShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'createFromBuild' 'myImage3' '--build' '18' '--pharoVersion' '10').
	
	self assertSuccess.
	self assert: self imageRepository imagesName equals: #('myImage1' 'myImage3' 'myImage2') asSet
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildAndShaAreBothPresent [
	
	self runCommand: #('launcher' 'image' 'createFromBuild' 'myImage3' '--pharoVersion' '10' '--build' '21' '--sha' 'f022266').
	
	self assert: (self errorString includesSubstring: PhLImageCreateFromBuildCliCommand missingOrDuplicatedBuildNumberOrShaMessage).
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenBuildAndShaAreMissing [
	
	self runCommand: #('launcher' 'image' 'createFromBuild' 'myImage3' '--pharoVersion' '10').
	
	self assert: (self errorString includesSubstring: PhLImageCreateFromBuildCliCommand missingOrDuplicatedBuildNumberOrShaMessage).
	self assert: self imageRepository imagesName equals: Set empty
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildShouldFailWhenPharoVersionIsMissing [
	
	self runCommand: #('launcher' 'image' 'createFromBuild' 'myImage3' '--build' '18').
	
	self assert: (self errorString includesSubstring: PhLImageCreateFromBuildCliCommand missingPharoVersionFlagMessage).
	self assert: self imageRepository imagesName equals: Set empty
]
