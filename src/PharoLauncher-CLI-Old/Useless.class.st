Class {
	#name : #Useless,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI-Old-PharoLauncher-CLI-Old'
}

{ #category : #'as yet unclassified' }
Useless class >> helpLauncherCommandLines [
   <commandline>
	^ (ClapCommand withName: 'launcherHelp')
		description: 'Prints all launcher commands available and their docs';
		meaning: [ :match | | doc parent query topic |
			doc := ClapDocumenter on: match context stdout.
			parent := match parent specification.
			query := match atName: 'topic'.
			topic := query value: parent.
			topic
				ifNil: [ match context exitFailure: 'Unknown subcommand: ' , query word ]
				ifNotNil: [ doc explain: topic ] ]

]

{ #category : #accessing }
Useless >> outputHelp [
]

{ #category : #accessing }
Useless >> stream: aWriteStream [ 
	stream := aWriteStream
]
