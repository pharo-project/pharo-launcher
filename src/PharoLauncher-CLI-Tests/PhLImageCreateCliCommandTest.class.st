Class {
	#name : #PhLImageCreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #utility }
PhLImageCreateCliCommandTest >> addLocalTemplateNamed: aName [ 
	^ self launcherModel templateRepository createLocalTemplateNamed: aName
	
]

{ #category : #creation }
PhLImageCreateCliCommandTest >> addTemplateCategoryNamed: aTemplateCategoryName [
	| templateCategory |
	templateCategory := self launcherModel templateRepository
		newRemoteTemplatesGroupNamed: aTemplateCategoryName.
	self launcherModel templateRepository
		setGroups: {templateCategory}
]

{ #category : #'instance creation' }
PhLImageCreateCliCommandTest >> addTemplateNamed: aName inCategory: aCategoryName [
	^ self launcherModel templateRepository
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
	self launcherModel
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
	self assert: (self imageRepository imageNamed: 'myimage3') isLaunched
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageWithNoLaunchFlagShouldNotLaunchImage [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage' . '--no-launch' . '--templateName'. 'fakeTemplate' . '--templateCategory' . self templateRepository localTemplatesGroupName}.
	 
	self assertSuccess.  
	self deny: (self imageRepository imageNamed: 'myimage') isLaunched
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageWithTooManyArgumentShouldRaiseError [

	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	self addTemplateNamed: 'fakeTemplate' inCategory: self defaultTemplateCategoryName.
	self addTemplateNamed: 'Pharo 9 64bit stable' inCategory: self defaultTemplateCategoryName.
	
	self runCommand: {'launcher' . 'image' . 'create' . 'myImage3' . 'templateName' . 'tooManyArguments'}.	 
	
	self assertFailure.
	"standard err stream should include error message for trailing unknown argument."
	self assert: (self errorString includesSubstring: 'tooManyArguments').
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageWithWrongTemplateNameShouldGiveErrorMessage [

	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	
	self runCommand: #('launcher' 'image' 'create' 'myImage3' '--templateName' 'aRandomTemplateName').
	self assertFailure.
		"standard err stream should include error message for unknown template."
	self assert: (self errorString includesSubstring: 'aRandomTemplateName not found')
]

{ #category : #tests }
PhLImageCreateCliCommandTest >> testCreateImageWithoutImageNameShouldGiveError [
		
	self runCommand: {'launcher' . 'image' . 'create' }.
	 
	self assertFailure.
	"standard err stream should include error message for missing image name."
	self assert: (self errorString includesSubstring: 'specify the name for the new Pharo image')
	
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
	self assertFailure.
	 
	self assert: (self errorString includesSubstring: 'wrong category name not found'). 
]
