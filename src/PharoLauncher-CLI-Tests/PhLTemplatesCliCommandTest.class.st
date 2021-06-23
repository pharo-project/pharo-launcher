Class {
	#name : #PhLTemplatesCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLTemplatesCliCommandTest >> addLocalTemplateNamed: aName [ 
	^ context launcherModel templateBaseRepository createLocalTemplateNamed: aName
]

{ #category : #adding }
PhLTemplatesCliCommandTest >> addTemplateCategoryNamed: aTemplateCategoryName [  
	| templateCategory |
	templateCategory := context launcherModel templateBaseRepository newRemoteTemplatesGroupNamed: aTemplateCategoryName.
	context launcherModel templateBaseRepository setGroups:{ templateCategory }.
]

{ #category : #adding }
PhLTemplatesCliCommandTest >> addTemplateNamed: aName inCategory: aCategoryName [ 
	^ context launcherModel templateBaseRepository createTemplateNamed: aName inCategory: aCategoryName
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> assertSuccess [
	self assert: context exitStatus equals: 0.
	self assert: self errorString equals: ''
]

{ #category : #creation }
PhLTemplatesCliCommandTest >> createOfficialTemplatesCategoryWithFakeTemplate [
	self addTemplateCategoryNamed: self defaultTemplateCategoryName.
	self addTemplateNamed: 'fakeTemplate' inCategory: self defaultTemplateCategoryName.
	self addTemplateNamed: 'Pharo 9 64bit stable' inCategory: self defaultTemplateCategoryName.
]

{ #category : #instance }
PhLTemplatesCliCommandTest >> defaultTemplateCategoryName [
	^ 'Official distributions'
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> errorString [
	^ context stdio stderr contents utf8Decoded
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> launcherModel [
	^ context launcherModel 
]

{ #category : #accessing }
PhLTemplatesCliCommandTest >> localTemplatesGroup [
	^ context templateRepository localTemplatesGroup
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]

{ #category : #tests }
PhLTemplatesCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model templateBaseRepository: PhLTemplateGroupTestRepository new.
	model templateBaseRepository createLocalTemplateNamed:'foo'.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model
]

{ #category : #'process actions' }
PhLTemplatesCliCommandTest >> templateRepository [ 
	^ self launcherModel templateBaseRepository
]
