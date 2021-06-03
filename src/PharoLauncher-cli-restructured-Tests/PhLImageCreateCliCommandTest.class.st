Class {
	#name : #PhLImageCreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #instance }
PhLImageCreateCliCommandTest >> PhLCliSpecificCommand [
	^ PhLImageCreateCliCommand asCliCommand: model
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('create' 'aRandomTemplateName' 'myImage3').
	 
	self assertSuccess.  
	self assert: model imageBaseRepository imagesName equals: #( 'myImage1' 'myImage3' 'myImage2' ) asSet. 
]
