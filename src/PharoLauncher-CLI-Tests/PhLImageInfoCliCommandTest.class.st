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
PhLImageInfoCliCommandTest >> testImageInfoWhenNoImageNameProvidedAllowsInteractiveImageSelection [

	| image1 image2 |
	image1 := self addImageNamed: 'myImageA'. "#1"
	image2 := self addImageNamed: 'myImageB'. "#2"
	image1 lastModification: image2 lastModification + 1 day.
	self addInputAnswer: '1'.
	
	self runCommand: #('launcher' 'image' 'info').
	 
	self assertSuccess.
	self assert: (self outputString includesSubstring:'https://testurl')
]

{ #category : #tests }
PhLImageInfoCliCommandTest >> testImageInfoWrongImageNameShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'info' 'myImage3').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'Please enter a correct local image.').
]
