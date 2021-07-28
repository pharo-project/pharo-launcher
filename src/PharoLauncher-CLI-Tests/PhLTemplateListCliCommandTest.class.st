Class {
	#name : #PhLTemplateListCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateAsStonShouldSucceed [
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'list' '--STON').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring:'PhLRemoteTemplate{#name:''fakeTemplate')
]

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateShouldSucceed [
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'list').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring:'fakeTemplate')
]

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateWithCategoryAsStonShouldSucceed [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'list' '--templateCategory' 'Local test templates' '--STON').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring:'PhLLocalTemplate{#name:''fakeTemplate''')
]

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateWithCategoryShouldSucceed [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'list' '--templateCategory' 'Local test templates').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring:'fakeTemplate')
]

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateWithWrongCategoryShouldRaiseErrorMessage [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'list' '--templateCategory' 'wrongCategoryName').
	
	self assert: (self errorString includesSubstring:'please enter a correct category')
]
