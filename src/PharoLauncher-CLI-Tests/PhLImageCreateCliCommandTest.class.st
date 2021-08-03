Class {
	#name : #PhLImageCreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #utility }
PhLImageCreateCliCommandTest >> addLocalTemplateNamed: aName [ 
	^ context launcherModel templateRepository createLocalTemplateNamed: aName
	
]

{ #category : #creation }
PhLImageCreateCliCommandTest >> addTemplateCategoryNamed: aTemplateCategoryName [
	| templateCategory |
	templateCategory := context launcherModel templateRepository
		newRemoteTemplatesGroupNamed: aTemplateCategoryName.
	context launcherModel templateRepository
		setGroups: {templateCategory}
]

{ #category : #'instance creation' }
PhLImageCreateCliCommandTest >> addTemplateNamed: aName inCategory: aCategoryName [
	^ context launcherModel templateRepository
		createTemplateNamed: aName
		inCategory: aCategoryName
]

{ #category : #instance }
PhLImageCreateCliCommandTest >> defaultTemplateCategoryName [
	^ 'Official distributions'
]

{ #category : #accessing }
PhLImageCreateCliCommandTest >> localTemplatesGroup [
	^ context templateRepository localTemplatesGroup
]

{ #category : #running }
PhLImageCreateCliCommandTest >> setUp [
	super setUp.
	context launcherModel
		templateRepository: PhLTemplateTestRepository new
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageFromABuildOfATemplateForPharo10ShouldReturnGoodURL [
	| url command |
	command := PhLImageCreateFromBuildCliCommand new. 
	url := command findURLOf: '10' build: '21' withSHA:'f022266' .
	self assert: url equals: 'https://files.pharo.org/image/100/Pharo10-SNAPSHOT.build.21.sha.f022266.arch.64bit.zip'  
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageFromABuildOfATemplateForPharo7ShouldReturnGoodURL [
	| url command |
	command := PhLImageCreateFromBuildCliCommand new.
	url := command findURLOf: '7' build: '510' withSHA: 'fb39ee7'.
	self assert: url equals: 'https://files.pharo.org/image/70/Pharo-7.0.0-alpha.build.510.sha.fb39ee7.arch.64bit.zip'
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageFromABuildOfATemplateForPharo8ShouldReturnGoodURL [
	| url command |
	command := PhLImageCreateFromBuildCliCommand new.
	url := command findURLOf: '8' build: '210' withSHA: '5da933e'.
	self assert: url equals: 'https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.210.sha.5da933e.arch.64bit.zip'
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageFromABuildOfATemplateForPharo9ShouldReturnGoodURL [
	| url command |
	command := PhLImageCreateFromBuildCliCommand new.
	url := command findURLOf: '9' build: '300' withSHA: 'b315fa8'.
	self assert: url equals: 'https://files.pharo.org/image/90/Pharo9.0-SNAPSHOT.build.300.sha.b315fa8.arch.64bit.zip'
	
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageFromABuildOfATemplateShouldSucceed [
	| memoryFileSystem test |
	memoryFileSystem := FileSystem memory.
	self
		runCommand:
			{'launcher' . 'image' . 'createFromBuild' . '10' . '18' . 'myNewImage'}
	"
	DiskStore
		currentFileSystem: memoryFileSystem 
		during: [ 
			self
				runCommand:
					{'launcher' . 'image' . 'createFromBuild' . '9' . '300' . 'b315fa8'.
					'myNewImage'}.
			self halt.
			]"
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
PhLImageCreateCliCommandTest >> testCreateImageWithToManyArgumentShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	self addTemplateNamed: 'fakeTemplate' inCategory: self defaultTemplateCategoryName.
	self addTemplateNamed: 'Pharo 9 64bit stable' inCategory: self defaultTemplateCategoryName.
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage3' . 'templateName' . 'tooManyArguments'}.
	 
	self assertFailure.  
	self assert: (self errorString includesSubstring: 'tooManyArguments').  
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
PhLImageCreateCliCommandTest >> testCreateImageWrongCategoryNameShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage3' . 'fakeTemplate' . '--templateCategory' . 'wrong category name'}.
	 
	self assert: (self errorString includesSubstring: 'cant find'). 
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testFindLatestPharoVersionInALocation [
	| category template1 template2 template3 templateFound |
	category := OrderedCollection new.
	template1 := PhLTemplateMock named: 'fakeTemplate1'.
	template2 := PhLTemplateMock
		named: 'fakeTemplateWith Pharo 9 64bit stable init'.
	template3 := PhLTemplateMock named: 'fakeTemplate3'.
	category
		add: template1;
		add: template2;
		add: template3.
		
	templateFound := PhLCliCommand new
		findLatestPharoStableVersionIn: category.
		
	self assert: (templateFound includesSubstring: 'stable').
	self assert: templateFound equals: template2 name
]
