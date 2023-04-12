Class {
	#name : #PhLTemplatesCliCommandTest,
	#superclass : #PhLCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLTemplatesCliCommandTest >> addLocalTemplateNamed: aName [ 
	^ self launcherModel templateRepository createLocalTemplateNamed: aName
]

{ #category : #adding }
PhLTemplatesCliCommandTest >> addTemplateCategoryNamed: aTemplateCategoryName [  
	| templateCategory |
	templateCategory := self launcherModel templateRepository newRemoteTemplatesGroupNamed: aTemplateCategoryName.
	context pharoLauncherModel templateRepository setGroups:{ templateCategory }.
]

{ #category : #adding }
PhLTemplatesCliCommandTest >> addTemplateNamed: aName inCategory: aCategoryName [ 
	^ self launcherModel templateRepository createTemplateNamed: aName inCategory: aCategoryName
]

{ #category : #creation }
PhLTemplatesCliCommandTest >> createOfficialTemplatesCategoryWithSomeTemplates [
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	self addTemplateNamed: 'fakeTemplate' inCategory: self defaultTemplateCategoryName.
	self addTemplateNamed: 'Pharo 9 64bit stable' inCategory: self defaultTemplateCategoryName.
]

{ #category : #instance }
PhLTemplatesCliCommandTest >> defaultTemplateCategoryName [
	^ 'Official distributions'
]

{ #category : #accessing }
PhLTemplatesCliCommandTest >> localTemplatesGroup [
	^ context templateRepository localTemplatesGroup
]

{ #category : #running }
PhLTemplatesCliCommandTest >> setUp [

	super setUp.
	self launcherModel templateRepository: PhLTemplateTestRepository new.
	self templateRepository createLocalTemplateNamed:'foo'.
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> templateRepository [ 
	^ self launcherModel templateRepository
]

{ #category : #tests }
PhLTemplatesCliCommandTest >> testExecuteLauncherTemplateCommandToPrintHelp [
	|expectedPrintout|
	expectedPrintout := 'Usage: launcher template'.
	
	self assertCommand: #('launcher' 'template') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'template' 'help') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'template' '--help') toPrintHelpWith: expectedPrintout.

]
