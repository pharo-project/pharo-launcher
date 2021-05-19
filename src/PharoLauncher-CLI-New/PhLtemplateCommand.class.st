"
Implement all the commands for the pharo launcher related to templates. 
"
Class {
	#name : #PhLtemplateCommand,
	#superclass : #Object,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> TemplatesCommands [
	<commandline>
	^(ClapCommand withName: 'template')
	 description: 'for templates';
	 add: (self list);
	 add: (self sourcesDirectory).
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> list [
	<commandline>
	^ (ClapCommand withName: 'list')
		description: 'Lists all the available templates on local computer.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				self outputListTemplatesAsSton. 
				ston exitSuccess ].
         self outputListTemplates 
		 ]
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> outputListTemplates [
	self new outputListTemplates
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> outputListTemplatesAsSton [
	self new outputListTemplatesAsSton
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> outputSourcesDirectoryTemplate [
   ^self new outputSourcesDirectoryTemplate
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> sourcesDirectory [
	<commandline>
	^ (ClapCommand withName: 'sourcesDir')
		description: 'Prints, set directory path where files with template sources is located';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				"self outputSourcesDirectoryAsSton." 
				ston exitSuccess ].
         self outputSourcesDirectoryTemplate
		 ]
]

{ #category : #initialization }
PhLtemplateCommand >> initialize [
   repository := PhLTemplateGroupRepository default.
	stream := VTermOutputDriver stdout.
]

{ #category : #initialization }
PhLtemplateCommand >> outputListTemplates [

	repository localTemplateNames
		do: [ :aTemplate | stream nextPutAll: aTemplate asString. stream cr. ]
]

{ #category : #initialization }
PhLtemplateCommand >> outputListTemplatesAsSton [
   stream nextPutAll: (STON toString: (repository localTemplateNames collect: [:each | each file ]))
]

{ #category : #initialization }
PhLtemplateCommand >> outputSourcesDirectoryTemplate [
   stream nextPutAll: repository localTemplatesDirectory asString. stream cr. 
   
]

{ #category : #initialization }
PhLtemplateCommand >> repository: aPhLMockTemplatesRepository [
	repository := aPhLMockTemplatesRepository
]

{ #category : #initialization }
PhLtemplateCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
