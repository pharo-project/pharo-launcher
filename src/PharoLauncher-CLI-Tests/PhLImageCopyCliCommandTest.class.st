Class {
	#name : #PhLImageCopyCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageNameAlreadyUsed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #('launcher' 'image' 'copy' 'myImage1' 'myImage2' ).
	 
	self assert: (self errorString includesSubstring:'Name already used'). 
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1' ) asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #('launcher' 'image' 'copy' 'myImage1' 'myImage3').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage3' 'myImage2' 'myImage1' ) asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageToManyArguments [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #( 'launcher' 'image' 'copy' 'myImage1' 'myImage2' 'blabla' ).
	 
	self deny: self errorString equals:''.  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1') asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageWrongName [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #('launcher' 'image' 'copy' 'myge1' 'myImage3' ).
	 
	self assert: (self errorString includesSubstring: 'please enter a correct local image').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1' ) asSet. 
]
