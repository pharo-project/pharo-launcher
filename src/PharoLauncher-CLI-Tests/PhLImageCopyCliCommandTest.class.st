Class {
	#name : #PhLImageCopyCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageNoArguments [

	self flag: 'TODO: waiting for validation of args/flags'.
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #( 'launcher' 'image' 'copy').
	 
	self assert: (self errorString includesSubstring:'Image to copy argument is missing.').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1') asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageNotEnoughArguments [

	self flag: 'Waiting for validation of args/flags'.
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #( 'launcher' 'image' 'copy' 'myImage1' ).
	 
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

	self flag: 'Waiting for validation of args/flags'.
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #( 'launcher' 'image' 'copy' 'myImage1' 'myImage2' 'blabla' ).
	 
	self assert: (self errorString includesSubstring:'Unrecognized arguments').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1') asSet. 
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageWrongName [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.

	self runCommand: #('launcher' 'image' 'copy' 'myge1' 'myImage3' ).
	 
	self assert: (self errorString includesSubstring: 'Please enter a correct local image').  
	self assert: self imageRepository imagesName equals: #('myImage2' 'myImage1' ) asSet. 
]
