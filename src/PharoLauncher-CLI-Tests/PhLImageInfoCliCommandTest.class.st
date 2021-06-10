Class {
	#name : #PhLImageInfoCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageInfoCliCommandTest >> testImageInfoShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'info' 'myImage1').
	
	self assert: (self outputString includesSubstring:'https://testurl').
]
