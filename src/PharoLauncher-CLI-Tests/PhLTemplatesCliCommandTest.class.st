Class {
	#name : #PhLTemplatesCliCommandTest,
	#superclass : #PhLCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLTemplatesCliCommandTest >> addLocalTemplateNamed: aName [ 
	^ context launcherModel templateRepository createLocalTemplateNamed: aName
]

{ #category : #adding }
PhLTemplatesCliCommandTest >> addTemplateCategoryNamed: aTemplateCategoryName [  
	| templateCategory |
	templateCategory := context launcherModel templateRepository newRemoteTemplatesGroupNamed: aTemplateCategoryName.
	context launcherModel templateRepository setGroups:{ templateCategory }.
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

{ #category : #tests }
PhLTemplatesCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model templateRepository: PhLTemplateTestRepository new.
	model templateRepository createLocalTemplateNamed:'foo'.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> templateRepository [ 
	^ self launcherModel templateRepository
]
