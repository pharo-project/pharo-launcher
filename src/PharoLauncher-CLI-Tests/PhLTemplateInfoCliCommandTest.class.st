Class {
	#name : #PhLTemplateInfoCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoShouldSucceed [
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'info' 'fakeTemplate').
	self assertSuccess.
	self outputString includesSubstring: 'fakeTemplate'.
	self outputString includesSubstring: 'URL'.

	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWithTemplateCategoryShouldSucceed [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'info' 'fakeTemplate' '--templateCategory' 'Local test templates').
	self assertSuccess.
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWithTooManyArgumentsShouldGiveErrorMessage [
	self createOfficialTemplatesCategoryWithSomeTemplates.
	self runCommand: #('launcher' 'template' 'info' 'someTemplate' 'tooManyArguments').
	self assertFailure.
	self assert: (self errorString includesSubstring:'tooManyArguments') .
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWithWrongTemplateNameShouldGiveBadCategoryMessage [
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'enter a correct template name')
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWrongTemplateName [
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'enter a correct template name')
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWrongTemplateNameWithCategory [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName' '--templateCategory' 'Local test templates').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'enter a correct template name')
	
]
