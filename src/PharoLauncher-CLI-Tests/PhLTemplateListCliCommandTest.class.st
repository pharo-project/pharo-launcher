Class {
	#name : #PhLTemplateListCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateAsStonShouldSucceed [

	| templates |
	self createOfficialTemplatesCategoryWithSomeTemplates. 	
	self runCommand: #('launcher' 'template' 'list' '--ston').
	
	self assertSuccess.
	templates := STON fromString: self outputString.
	self assert: templates size equals: 2.
	self assert: (templates first) name equals:'fakeTemplate'.
	
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

	| templateCategory |
	self addLocalTemplateNamed: 'fakeTemplate'.	
	self runCommand: #('launcher' 'template' 'list' '--templateCategory' 'Local test templates' '--ston').
	
	self assertSuccess.
	templateCategory := ( STON fromString: self outputString).
	self assert: (templateCategory first) name equals:'fakeTemplate'
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
	self assertFailure.
	self assert: (self errorString includesSubstring: 'enter a correct image tamplate category name')
]
