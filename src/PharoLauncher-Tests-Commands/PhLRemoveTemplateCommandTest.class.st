Class {
	#name : #PhLRemoveTemplateCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #accessing }
PhLRemoveTemplateCommandTest >> removeTemplateMenuItem [
	| menu menuItems |
	menu := (presenter rootCommandsGroup / 'Context Menu')
		asMenuPresenter.
	menuItems := menu menuGroups flatCollect: #menuItems.
	^ menuItems detect: [ :item | item name = 'Remove template' ]
]

{ #category : #running }
PhLRemoveTemplateCommandTest >> setUp [
	presenter := PhLTestTemplatesPresenter new.
	presenter selectLocalGroup.
]

{ #category : #tests }
PhLRemoveTemplateCommandTest >> testCanRemoveALocalTemplate [
	| command |
	command := PhLRemoveTemplateCommand2 new.
	command context: presenter.
	presenter
		createLocalTemplateNamed: 'Foo';
		selectTemplateNamed: 'Foo'.
		
	command execute.
	
	self 
		assertCollection: presenter templateNames
		hasSameElements: #().
		
	self assert: presenter templateRoots isEmpty.
]

{ #category : #tests }
PhLRemoveTemplateCommandTest >> testCanRemoveManyLocalTemplates [
	| command |
	command := PhLRemoveTemplateCommand2 new.
	command context: presenter.
	presenter
		createLocalTemplateNamed: 'Foo';
		createLocalTemplateNamed: 'Bar';
		createLocalTemplateNamed: 'Zee';
		selectTemplateNamed: 'Foo';
		selectTemplateNamed: 'Bar'.
		
	command execute.
	
	self 
		assertCollection: presenter templateNames
		hasSameElements: #('Zee').
		
	self 
		assertCollection: (presenter templateRoots collect: #name)
		hasSameElements: #('Zee').
]

{ #category : #tests }
PhLRemoveTemplateCommandTest >> testCommandAvailableWhenThereIsALocalTemplateSelected [
	| command |
	command := PhLRemoveTemplateCommand2 new.
	command context: presenter.
	presenter
		createLocalTemplateNamed: 'Foo';
		selectTemplateNamed: 'Foo'.
	
	self assert: self removeTemplateMenuItem isEnabled
]

{ #category : #tests }
PhLRemoveTemplateCommandTest >> testCommandHasNoEffectWhenNoTemplateSelected [
	| command |
	command := PhLRemoveTemplateCommand2 new.
	command context: presenter.
	presenter createLocalTemplateNamed: 'Foo'. 

	command execute.
	
	self 
		assertCollection: presenter templateNames
		hasSameElements: #( #Foo )
]

{ #category : #tests }
PhLRemoveTemplateCommandTest >> testCommandNotAvailableWhenThereIsARemoteTemplateSelected [
	| command |
	command := PhLRemoveTemplateCommand2 new.
	command context: presenter.
	presenter
	 	createRemoteTemplateNamed: 'Foo';
		selectRemoteGroup;
		selectTemplateNamed: 'Foo'. 
	
 	self deny: self removeTemplateMenuItem isEnabled
]

{ #category : #tests }
PhLRemoveTemplateCommandTest >> testCommandNotAvailableWhenThereIsNoTemplateSelected [
	| command |
	command := PhLRemoveTemplateCommand2 new.
	command context: presenter.
	
 	self deny: self removeTemplateMenuItem isEnabled
]
