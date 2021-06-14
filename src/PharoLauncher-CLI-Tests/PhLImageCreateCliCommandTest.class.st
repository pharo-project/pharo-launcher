Class {
	#name : #PhLImageCreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'process',
		'imageDir'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #utility }
PhLImageCreateCliCommandTest >> addLocalTemplateNamed: aName [ 
	^ context launcherModel templateBaseRepository createLocalTemplateNamed: aName
	
]

{ #category : #accessing }
PhLImageCreateCliCommandTest >> localTemplatesGroup [
	^ context launcherModel templateBaseRepository localTemplatesGroup
]

{ #category : #utilities }
PhLImageCreateCliCommandTest >> newZipArchive: aFileReference [ 
	self shouldBeImplemented.
]

{ #category : #running }
PhLImageCreateCliCommandTest >> setUp [
	
	super setUp.
	context launcherModel templateBaseRepository: PhLTemplateGroupTestRepository new

]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'image' 'create' 'fakeTemplate' 'myImage3' '--templateCategory' 'Local test templates').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage1' 'myImage3' 'myImage2' ) asSet. 
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageWithWrongTemplateNameShouldGiveErrorMessage [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'create' 'aRandomTemplateName' 'myImage3').
	 
	self assert: (self errorString includesSubstring:'cant find the template')
]
