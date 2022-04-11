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
	
	self assert: (self errorString includesSubstring:'tooManyArguments') .
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWithWrongTemplateNameShouldGiveBadCategoryMessage [
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName').
	
	self assert: (self errorString includesSubstring:'please enter a correct template name') .
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWrongTemplateName [
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName').
	
	self assert: (self errorString includesSubstring:'please enter a correct template name') .
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWrongTemplateNameWithCategory [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName' '--templateCategory' 'Local test templates').
	
	self assert: (self errorString includesSubstring:'please enter a correct template name') .
	
	
]
