Class {
	#name : #PhLImageCreateFromBuildCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildOfATemplateOnOwnComputerToImplementTheCommand [
			self
				runCommand:
					{'launcher' . 'image' . 'createFromBuild' . '10' . '21' . 'myNewImage'}.
]

{ #category : #tests }
PhLImageCreateFromBuildCliCommandTest >> testCreateImageFromABuildOfATemplateShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self
		runCommand:
			#('launcher' 'image' 'createFromBuild' 'myImage3' '--build' '18' '--pharoVersion' '10' ).
	self assertSuccess.
	self assert: self imageRepository imagesName equals: #('myImage1' 'myImage3' 'myImage2') asSet
]
