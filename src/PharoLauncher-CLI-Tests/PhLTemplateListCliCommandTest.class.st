Class {
	#name : #PhLTemplateListCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateAsStonShouldSucceed [
	| test |
	self createOfficialTemplatesCategoryWithSomeTemplates. 
	
	self runCommand: #('launcher' 'template' 'list' '--ston').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring:'PhLRemoteTemplate{#name:''fakeTemplate').
	test := STON fromString: self outputString.
	self assert: (test at:1) name equals:'fakeTemplate'
	
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
	
	self runCommand: #('launcher' 'template' 'list' '--templateCategory' 'Local test templates' '--ston').
	
	self assertSuccess.
	
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
