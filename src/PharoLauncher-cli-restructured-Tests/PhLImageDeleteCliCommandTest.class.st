Class {
	#name : #PhLImageDeleteCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #instance }
PhLImageDeleteCliCommandTest >> PhLCliSpecificCommand [
	^ PhLImageDeleteCliCommand asCliCommand: model
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('delete' 'myImage1').
	 
	self assertSuccess.  
	self assert: model imageBaseRepository imagesName equals: #( 'myImage2' ) asSet. 
]
