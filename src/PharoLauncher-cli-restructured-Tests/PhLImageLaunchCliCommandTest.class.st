Class {
	#name : #PhLImageLaunchCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageShouldSucceed [
	| image |
	image := self addImageNamed: 'myImage1'.
	
	"self runCommand: #( 'image' 'image' 'launch' 'myImage1')."
	self runCommand: #('launcher' 'image' 'launch' 'myImage1').
	
	self assert: self errorString equals:''.
	self assertSuccess.  
	self assert: image isLaunched. 

	
]

{ #category : #tests }
PhLImageLaunchCliCommandTest >> testLaunchImageToManyArguments [

	| image |
	image := self addImageNamed: 'myImage1'.
	
	self runCommand: #('launch' '4' 'myImage1').
	 
	self assert: (self errorString includesSubstring: 'Unrecognized arguments: myImage1').
	self assertFailure.  
	self deny: image isLaunched. 

	

	
]
