Class {
	#name : #PhLImageCopyCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageNoArguments [

	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #( 'launcher' 'image' 'copy').
	self assertFailure.
	
	self assert: (self errorString includesSubstring:'Image to copy argument is missing.').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1') asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageNotEnoughArguments [

	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #( 'launcher' 'image' 'copy' 'myImage1' ).
	self assertFailure.
	
	"standard err stream should include error message for missing argument." 
	self assert: (self errorString includesSubstring: 'An argument is missing. Please specify the name for the new Pharo image.').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1') asSet. 
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
	self assertFailure.
	"standard err stream should include error message for trailing unknown argument." 
	self assert: (self errorString includesSubstring:'Unrecognized arguments').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1') asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageWrongName [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #('launcher' 'image' 'copy' 'myge1' 'myImage3' ).
	self assertFailure.
	"standard err stream should include error message for wrong image name argument." 
	self assert: (self errorString includesSubstring: 'Please enter a correct local image').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1' ) asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyTargetImageAlreadyUsed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #('launcher' 'image' 'copy' 'myImage1' 'myImage2' ).
	self assertFailure.
	"standard err stream should include error message for image already used." 
	self assert: (self errorString includesSubstring: 'already used').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1' ) asSet.
]
