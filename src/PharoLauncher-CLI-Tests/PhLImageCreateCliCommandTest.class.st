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
PhLImageCreateCliCommandTest >> testCreateImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage3' . '--templateName'. 'fakeTemplate' . '--templateCategory' . self templateRepository localTemplatesGroupName}.
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage1' 'myImage3' 'myImage2' ) asSet. 
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageWithToManyArgumentShouldRaiseError [

	self flag: 'Waiting for validation of args/flags'.
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

	self flag: 'Default value evaluation of flag with parameter needs to be fixed'.
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	
	self runCommand: #('launcher' 'image' 'create' 'myImage3' '--templateName' 'aRandomTemplateName').
	self assert: (self errorString includesSubstring: 'aRandomTemplateName not found')
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
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage3' . '--templateName'. 'fakeTemplate' . '--templateCategory' . 'wrong category name'}.
	 
	self assert: (self errorString includesSubstring: 'wrong category name not found'). 
]
