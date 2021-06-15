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

{ #category : #creation }
PhLImageCreateCliCommandTest >> addTemplateCategoryNamed: aTemplateCategoryName [  
	| templateCategory |
	templateCategory := context launcherModel templateBaseRepository newRemoteTemplatesGroupNamed: aTemplateCategoryName.
	context launcherModel templateBaseRepository setGroups:{ templateCategory }.
	
]

{ #category : #'instance creation' }
PhLImageCreateCliCommandTest >> addTemplateNamed: aName inCategory: aCategoryName [ 
	^ context launcherModel templateBaseRepository createTemplateNamed: aName inCategory: aCategoryName
]

{ #category : #instance }
PhLImageCreateCliCommandTest >> defaultTemplateCategoryName [
	^ 'Official distributions'
]

{ #category : #accessing }
PhLImageCreateCliCommandTest >> localTemplatesGroup [
	^ context templateRepository localTemplatesGroup
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
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage3' . 'fakeTemplate' . '--templateCategory' . self templateRepository localTemplatesGroupName}.
	 
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

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageWithoutTemplateArgumentShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	self addTemplateNamed: 'fakeTemplate' inCategory: self defaultTemplateCategoryName.
	self addTemplateNamed: 'Pharo 9 64bit stable' inCategory: self defaultTemplateCategoryName.
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage3' }.
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage1' 'myImage3' 'myImage2' ) asSet. 
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testFindLastestPharoVersionInALocation [
	| category template1 template2 template3 templateFound |
	category := OrderedCollection new. 
	template1 := PhLTemplateMock named:'fakeTemplate1'.
	template2 := PhLTemplateMock named:'fakeTemplateWith Pharo 9 64bit stable init'.
	template3 := PhLTemplateMock named:'fakeTemplate2'.
	category add: template1;
	add:template2;
	add: template3.
	
	templateFound := PhLCliCommand new findLatestPharoStableVersionInALocation: category.
	
	self assert: (templateFound includesSubstring: 'stable')
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testFindLastestPharoVersionInALocation: aLocation [
	| templateName command |
	command := context arguments: #('launcher' 'image' 'create' 'template' 'myImageName').
	command ifMatch: [:match|
		 command := match value: context ].
	
	templateName := command findLatestPharoStableVersion.
	
	self assert: (templateName includesSubstring: '8 stable')
]
