"
Command to list all the templates on the local machine.
"
Class {
	#name : #ClapListTemplates,
	#superclass : #Object,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'as yet unclassified' }
ClapListTemplates class >> listTemplates [
	<commandline>
	^ (ClapCommand withName: 'listTemplates')
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
ClapListTemplates class >> outputListTemplates [
	self new outputListTemplates
]

{ #category : #initialization }
ClapListTemplates class >> outputListTemplatesAsSton [
	self new outputListTemplatesAsSton
]

{ #category : #initialization }
ClapListTemplates >> initialize [
   repository := PhLTemplateGroupRepository default.
	stream := VTermOutputDriver stdout.
]

{ #category : #initialization }
ClapListTemplates >> outputListTemplates [

	repository localTemplateNames
		do: [ :aTemplate | stream nextPutAll: aTemplate asString. stream cr. ]
]

{ #category : #initialization }
ClapListTemplates >> outputListTemplatesAsSton [
   stream nextPutAll: (STON toString: (repository localTemplateNames collect: [:each | each file ]))
]

{ #category : #initialization }
ClapListTemplates >> repository: aPhLMockTemplatesRepository [
	repository := aPhLMockTemplatesRepository
]

{ #category : #initialization }
ClapListTemplates >> stream: aWriteStream [ 
	stream := aWriteStream
]
