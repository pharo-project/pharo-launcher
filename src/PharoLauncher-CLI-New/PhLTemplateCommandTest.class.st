Class {
	#name : #PhLTemplateCommandTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #tests }
PhLTemplateCommandTest >> testListInCatTemplatesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'template'].
	command := command subcommands detect:[ :f | f canonicalName ='listTemplatesInCat'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLTemplateCommandTest >> testListTemplatesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'template'].
	command := command subcommands detect:[ :f | f canonicalName ='list'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLTemplateCommandTest >> testSourcesDirectoryTemplatesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'template'].
	command := command subcommands detect:[ :f | f canonicalName ='sourcesDir'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLTemplateCommandTest >> testSourcesURLTemplatesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'template'].
	command := command subcommands detect:[ :f | f canonicalName ='sourcesUrl'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLTemplateCommandTest >> testTemplateCategories [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'template'].
	command := command subcommands detect:[ :f | f canonicalName ='sourcesUrl'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLTemplateCommandTest >> testTemplatesCategoryWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'template'].
	command := command subcommands detect:[ :f | f canonicalName ='categories'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]
