Class {
	#name : #PhLImageDeleteCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageNameWithoutImageNameShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'delete').
 
	self assert: ( self errorString includesSubstring: 'please enter a correct local image').  
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'delete' 'myImage1').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage2' ) asSet. 
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageWrongImageNameShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'delete' 'wrongImageName').
	  
	self assert: (self errorString includesSubstring: 'please enter a correct local image').  
]
