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
		'outStream'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLCliCommand class >> asCliCommand [

	self subclassResponsibility 
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
			args at: #helpFlag ifPresent: [ :help |
				help value; exitSuccess ].
			(self with: args) execute ];
		yourself
]

{ #category : #'command line - instance creation' }
PhLCliCommand class >> newLauncherCommand: idOfCommand launcherModel: aLauncherModel [

	"factory for pharo launcher commands"
	
	^ (ClapCommand id: idOfCommand)
		description: self launcherCmdDescription;
		add: ClapFlag forHelp;
		addAll: self launcherCmdSubcommands;
		addAll: self launcherCmdPositionals;
		addAll: self launcherCmdFlags;
		meaning: [ :args |
			args validateAll.
			args at: #helpFlag ifPresent: [ :help |
				help value; exitSuccess ].
			(self with: args) execute:aLauncherModel ];
		yourself
]

{ #category : #'command execution' }
PhLCliCommand >> execute [ 
	
	^ self context exitSuccess.
]

{ #category : #'private ' }
PhLCliCommand >> outStream [ 

	self flag: 'TODO: Test behavior of outstream (instance of VTermOutputDriver on Windows 10).'.
	^ outStream ifNil: [ outStream := VTermOutputDriver on: arguments context stdout ]
]
