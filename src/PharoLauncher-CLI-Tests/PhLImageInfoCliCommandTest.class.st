Class {
	#name : #PhLImageInfoCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageInfoCliCommandTest >> testImageInfoShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'info' 'myImage1').
	self assertSuccess.
	self assert: (self outputString includesSubstring:'https://testurl').
]

{ #category : #tests }
PhLImageInfoCliCommandTest >> testImageInfoWrongImageNameShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'info' 'myImage3').
	self assertFailure.
	self assert: (self errorString includesSubstring:'Please enter a correct local image.').
]
