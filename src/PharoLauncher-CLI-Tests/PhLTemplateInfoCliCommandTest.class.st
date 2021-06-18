Class {
	#name : #PhLTemplateInfoCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoShouldSucceed [
	self createOfficialRepositoryInFileSystemWithTemplatesInIt. 
	
	self runCommand: #('launcher' 'template' 'info' 'fakeTemplate').
	
	self assertSuccess.
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoToManyArguments [
	self createOfficialRepositoryInFileSystemWithTemplatesInIt. 
	
	self runCommand: #('launcher' 'template' 'info' 'oneArgument' 'tooManyArguments').
	
	self assert: (self errorString includesSubstring:'tooManyArguments') .
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWithTemplateCategoryShouldSucceed [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'info' 'fakeTemplate' '--templateCategory' 'Local test templates').
	
	self assertSuccess.
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWrongTemplateName [
	self createOfficialRepositoryInFileSystemWithTemplatesInIt. 
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName').
	
	self assert: (self errorString includesSubstring:'please enter a correct template name') .
	
	
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoWrongTemplateNameWithCategory [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'info' 'wrongTemplateName' '--templateCategory' 'Local test templates').
	
	self assert: (self errorString includesSubstring:'please enter a correct template name') .
	
	
]
