Class {
	#name : #PhLImageListCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'list').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:'myImage1').
	self assert: (self outputString includesSubstring:'myImage2')
]
