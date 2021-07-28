Class {
	#name : #PhLImageListCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageListCliCommandTest >> testListEmptyListImageShouldSucceed [
	
	self runCommand: #('launcher' 'image' 'list').
	 
	self assertSuccess.  
	self assert: self outputString equals:''.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'list').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:'myImage1').
	self assert: (self outputString includesSubstring:'myImage2').
	self assert: (self outputString includesSubstring:'architecture: 64').
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageShouldSucceedOutputInSTON [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'list' '--STON').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:'PhLImagesMock{#name:''myImage1''').
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageWithImageNameShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addImageNamed: 'shouldNotBeListed'.
	self addImageNamed: 'myImage3'.
	
	self runCommand: #('launcher' 'image' 'list' '--name' 'myImage').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:'myImage1').
	self assert: (self outputString includesSubstring:'myImage2').
	self assert: (self outputString includesSubstring:'myImage3').
	self deny: (self outputString includesSubstring: 'shouldNotBeListed')
]
