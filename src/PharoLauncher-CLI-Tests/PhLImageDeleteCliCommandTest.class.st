Class {
	#name : #PhLImageDeleteCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageNameWithPathShouldRaiseError [
	|  imagePath root |
	root := FileSystem memory root.
	imagePath := root / 'testImage.image'.
	imagePath ensureCreateFile.
	

	self runCommand: {'launcher' . 'image' . 'delete' . imagePath asString }.
	self assertFailure.
	self
		assert:
			(self errorString
				includesSubstring: 'Please enter a correct local image').
	self assert: imagePath isFile.
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageShouldAbortIfNotConfirmed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addInputAnswer: 'n'. "cancel deletion"
	
	self runCommand: #('launcher' 'image' 'delete' 'myImage1').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #('myImage1' 'myImage2') asSet. 
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addInputAnswer: 'y'. "confirm deletion"
	
	self runCommand: #('launcher' 'image' 'delete' 'myImage1').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage2' ) asSet. 
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageWhenNoImageNameProvidedAllowsDeletionByInteractiveImageSelection [

	| image1 image2 |
	image1 := self addImageNamed: 'myImageA'. "#1"
	image2 := self addImageNamed: 'myImageB'. "#2"
	image1 lastModification: image2 lastModification + 1 day.
	self addInputAnswer: '1'.
	self addInputAnswer: 'y'. "confirm deletion"
	
	self runCommand: #('launcher' 'image' 'delete').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImageB' ) asSet
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageWrongImageNameShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'delete' 'wrongImageName').
	self assertFailure.  
	self assert: (self errorString includesSubstring: 'Please enter a correct local image')
]
