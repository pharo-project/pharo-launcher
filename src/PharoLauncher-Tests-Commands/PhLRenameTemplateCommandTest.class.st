Class {
	#name : #PhLRenameTemplateCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #'as yet unclassified' }
PhLRenameTemplateCommandTest >> renameTemplateMenuItem [
	| menu menuItems |
	menu := (presenter rootCommandsGroup / 'Context Menu')
		asMenuPresenter.
	menuItems := menu menuGroups flatCollect: #menuItems.
	^ menuItems detect: [ :item | item name = 'Rename template' ]
]

{ #category : #running }
PhLRenameTemplateCommandTest >> setUp [
	presenter := PhLTestTemplatesPresenter new.
	presenter selectLocalGroup.
]

{ #category : #tests }
PhLRenameTemplateCommandTest >> testCanRenameALocalTemplate [
	| command |
	command := PhLRenameTemplateCommand new.
	command context: presenter.
	presenter
		createLocalTemplateNamed: 'Foo';
		selectTemplateNamed: 'Foo';
		requestAnswer: 'Bar'.
		
	command execute.
	
	self 
		assertCollection: presenter templateNames
		hasSameElements: #(Bar).
		
	self 
		assert: presenter templateRoots size
		equals: 1.
]

{ #category : #tests }
PhLRenameTemplateCommandTest >> testCommandAvailableWhenThereIsALocalTemplateSelected [
	| command |
	command := PhLRenameTemplateCommand new.
	command context: presenter.
	presenter
		createLocalTemplateNamed: 'Foo';
		selectTemplateNamed: 'Foo'.
	
	self assert: self renameTemplateMenuItem isEnabled
]

{ #category : #tests }
PhLRenameTemplateCommandTest >> testCommandHasNoEffectWhenNoTemplateSelected [
	| command |
	command := PhLRenameTemplateCommand new.
	command context: presenter.
	presenter createLocalTemplateNamed: 'Foo'. 

	self
		should: [ command execute ]
		raise: PhLCommandError.
	
	self 
		assertCollection: presenter templateNames
		hasSameElements: #( #Foo )
]

{ #category : #tests }
PhLRenameTemplateCommandTest >> testCommandNotAvailableWhenThereIsARemoteTemplateSelected [
	| command |
	command := PhLRenameTemplateCommand new.
	command context: presenter.
	presenter
	 	createRemoteTemplateNamed: 'Foo';
		selectRemoteGroup;
		selectTemplateNamed: 'Foo'. 
	
 	self deny: self renameTemplateMenuItem isEnabled
]

{ #category : #tests }
PhLRenameTemplateCommandTest >> testCommandNotAvailableWhenThereIsNoTemplateSelected [
	| command |
	command := PhLRenameTemplateCommand new.
	command context: presenter.
	
 	self deny: self renameTemplateMenuItem isEnabled
]
