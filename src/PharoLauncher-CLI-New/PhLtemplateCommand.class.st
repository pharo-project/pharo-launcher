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
	 add: (self listTemplatesInCat);
	 add: (self sourcesDirectory);
	 add: (self sourcesUrl);
	 add: (self categories).
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> categories [
	<commandline>
	^ (ClapCommand withName: 'categories')
		description: 'List all images templates categories.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				"self outputListTemplatesAsSton." 
				ston exitSuccess ].
         self outputTemplateCategories 
		 ]
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
PhLtemplateCommand class >> listTemplatesInCat [
	<commandline>
	^ (ClapCommand withName: 'listTemplatesInCat')
		description: 'Lists all the available templates in a template category.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args | |aCategory|
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				"self outputListTemplatesAsSton." 
				ston exitSuccess ].
			aCategory := args parent parent parent arguments at:3. 
         self outputListTemplatesInCat: aCategory 
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
PhLtemplateCommand class >> outputListTemplatesInCat: aCategory [ 
   self new outputListTemplatesInCat: aCategory.
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> outputSourcesDirectoryTemplate [
   ^self new outputSourcesDirectoryTemplate
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> outputSourcesUrlTemplate [
   ^self new outputSourcesUrlTemplate
]

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> outputTemplateCategories [
   ^self new outputTemplateCategories
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

{ #category : #'as yet unclassified' }
PhLtemplateCommand class >> sourcesUrl [
   <commandline>
	^ (ClapCommand withName: 'sourcesUrl')
		description: 'Prints (sets), https Url where template sources can be fetched remote site';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				"self outputSourcesDirectoryAsSton." 
				ston exitSuccess ].
         self outputSourcesUrlTemplate
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
PhLtemplateCommand >> outputListTemplatesInCat: aCategory [
   | listTemplatesAvailableForDownload |
   listTemplatesAvailableForDownload := PhLTemplateGroupRepository default roots. 
   [listTemplatesAvailableForDownload := listTemplatesAvailableForDownload  detect: [:aGroup | aGroup asString = aCategory asString ]]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct template category name'.stream cr.^0].
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload children.
   listTemplatesAvailableForDownload do: [ :template | stream nextPutAll: template name. stream lf ]
   
]

{ #category : #initialization }
PhLtemplateCommand >> outputSourcesDirectoryTemplate [
   stream nextPutAll: repository localTemplatesDirectory asString. stream cr. 
   
]

{ #category : #initialization }
PhLtemplateCommand >> outputSourcesUrlTemplate [
	| listTemplatesAvailableForDownload |
   listTemplatesAvailableForDownload := PhLTemplateGroupRepository default roots. 
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload  detect: [:aGroup | aGroup name = 'Official distributions'  ].
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload children.
   listTemplatesAvailableForDownload do: [ :template | stream nextPutAll: template name.stream nextPutAll:': '.stream nextPutAll: (template url asString ). stream lf ]
   
]

{ #category : #initialization }
PhLtemplateCommand >> outputTemplateCategories [
	| listTemplatesAvailableForDownload |
   listTemplatesAvailableForDownload := PhLTemplateGroupRepository default roots. 
   listTemplatesAvailableForDownload do: [ :category | stream nextPutAll: category asString; lf. ]
   
]

{ #category : #initialization }
PhLtemplateCommand >> repository: aPhLMockTemplatesRepository [
	repository := aPhLMockTemplatesRepository
]

{ #category : #initialization }
PhLtemplateCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
