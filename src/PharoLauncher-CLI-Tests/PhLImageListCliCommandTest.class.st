Class {
	#name : #PhLImageListCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageListCliCommandTest >> testDelimiter [


	| aCommand |
	aCommand := (PhLImageListCliCommand asCliCommand activationWith: #('list'  '--delimiter' ' * ')) command.

	self assert: aCommand delimiter equals: ' * '.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testDelimiterImplicit [

	| aCommand |
	aCommand := (PhLImageListCliCommand asCliCommand activationWith: #('list')) command.
	self assert: aCommand delimiter equals: ' '.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListEmptyImageRepositoryShouldSucceed [
	
	self runCommand: #('launcher' 'image' 'list').
	 
	self assertSuccess.
	self assert: self outputString equals:''.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'list' '--brief' '--delimiter' '+').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:' +myImage1').
	self assert: (self outputString includesSubstring:' +myImage2').
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageShouldSucceedOutputInSTON [
	| images |
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'list' '--ston').
	 
	self assertSuccess.  
	images := STON fromString: self outputString.
	self 
		assertCollection: (images collect: #name)
		hasSameElements: #('myImage1' 'myImage2').
	
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageWithImageNameFilterShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addImageNamed: 'shouldNotBeListed'.
	self addImageNamed: 'myImage3'.
	
	self runCommand: #('launcher' 'image' 'list' '--nameFilter' 'myImage').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:'myImage1').
	self assert: (self outputString includesSubstring:'myImage2').
	self assert: (self outputString includesSubstring:'myImage3').
	self deny: (self outputString includesSubstring: 'shouldNotBeListed')
]
