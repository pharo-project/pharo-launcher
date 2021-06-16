"
I represent Pharo Launcher root command line command - entry point for invoking PharoLauncher from cmd line. 

I use: 
 - CLAP for interacting with command line (inherit behavior from ClapApplication).

I declare: 
- outStream for printing command line output

I execute:
- just printing help about my sub-commands relevant for Pharo Launcher
"
Class {
	#name : #PhLCliCommand,
	#superclass : #ClapApplication,
	#instVars : [
		'outStream',
		'pharoLauncherModel',
		'errorStream'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #launcher 
]

{ #category : #'command line - description' }
PhLCliCommand class >> launcherCmdDescription [
	^ 'This is command line interface of Pharo Launcher. Create Pharo image from remote site template, lauch Pharo, eventually delete image, update VMs, etc.'
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> launcherCmdFlags [

	^ #()
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> launcherCmdPositionals [

	^ #()
]

{ #category : #'command line - subcommands' }
PhLCliCommand class >> launcherCmdSubcommands [

	^ self subclasses collect: #asCliCommand
]

{ #category : #'command line - instance creation' }
PhLCliCommand class >> launcherCommand [
	"Root command for Pharo Launcher"
	<commandline>
	
	^ self newLauncherCommand: #launcher
]

{ #category : #'command line - description' }
PhLCliCommand class >> launcherDescription [
	^ 'This is command line interface of Pharo Launcher. Create Pharo image from remote site template, lauch Pharo, eventually delete image, update VMs, etc.'
]

{ #category : #'command line - instance creation' }
PhLCliCommand class >> newLauncherCommand: idOfCommand [ 
	"factory for pharo launcher commands"
	^ (ClapCommand id: idOfCommand)
		description: self launcherCmdDescription;
		add: ClapFlag forHelp;
		addAll: self launcherCmdSubcommands;
		addAll: self launcherCmdPositionals;
		addAll: self launcherCmdFlags;
		meaning: [ :args | 
			args validateAll.
			args
				at: #helpFlag
				ifPresent: [ :help | 
					help
						value;
						exitSuccess ].
			(self with: args) execute ];
		yourself
]

{ #category : #'as yet unclassified' }
PhLCliCommand >> defaultTemplateCategoryName [
	^ 'Official distributions'
]

{ #category : #'private ' }
PhLCliCommand >> errorStream [ 
	^ errorStream ifNil: [ errorStream := VTermOutputDriver on: arguments context stderr ]
]

{ #category : #'command execution' }
PhLCliCommand >> execute [ 
	
	^ self context exitSuccess.
]

{ #category : #querying }
PhLCliCommand >> findLatestPharoStableVersionInALocation: aLocation [ 
	^ (aLocation detect: [ :template | template name includesSubstring: 'stable';includesSubstring: '64bit' ]) name
	
]

{ #category : #accessing }
PhLCliCommand >> imageRepository [ 
	^ self pharoLauncherModel imageBaseRepository
]

{ #category : #'instance creation' }
PhLCliCommand >> list: aCollection [ 
	| counter |
	counter := 1.
	aCollection
		do: [ :anItem | 
			self outStream
				nextPutAll: counter asString;
				nextPutAll: ': ';
				nextPutAll: anItem cliPrintString;
				newLine.
			counter := counter + 1 ]
]

{ #category : #'private ' }
PhLCliCommand >> outStream [ 
	^ outStream ifNil: [ outStream := VTermOutputDriver on: arguments context stdout ]
]

{ #category : #accessing }
PhLCliCommand >> pharoLauncherModel [
	^ self context launcherModel
]

{ #category : #default }
PhLCliCommand >> returnDefaultTemplateCategory [
	^ self templateRepository categoryNamed: self defaultTemplateCategoryName 
]

{ #category : #initialization }
PhLCliCommand >> setPharoLauncherModel: aPharoLauncherModel [ 
	pharoLauncherModel := aPharoLauncherModel 
]

{ #category : #accessing }
PhLCliCommand >> templateRepository [ 
	^ self pharoLauncherModel templateBaseRepository
]

{ #category : #accessing }
PhLCliCommand >> vmRepository [ 
	^ self pharoLauncherModel vmBaseRepository availableVirtualMachines values
]
