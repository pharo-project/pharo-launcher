Class {
	#name : #PhLImageCopyCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #instance }
PhLImageCopyCliCommandTest >> PhLCliSpecificCommand [
	^ PhLImageCopyCliCommand asCliCommand: model
]

{ #category : #tests }
PhLImageCopyCliCommandTest >> testCopyImageSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'copy' 'myImage1' 'myImage3').
	 
	self assertSuccess.  
	self assert: model imageBaseRepository imagesName equals: #( 'myImage3' 'myImage2' 'myImage1' ) asSet. 
]
