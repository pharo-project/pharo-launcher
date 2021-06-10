Class {
	#name : #PhLImageDeleteCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'delete' 'myImage1').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage2' ) asSet. 
]
