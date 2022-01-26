"
I represent Pharo Launcher root command line command - entry point for invoking PharoLauncher from cmd line. It is the super class of all pharo launcher cli commands providing acces to output streams, pharo launcher model, etc

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
		'errorStream',
		'cliFormatter'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #launcher 
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> briefFlag [

	^ ((ClapFlag id: #brief)
		description: 'Prints only name attribute (with leading sequence number).';
		meaning: [ :arg :app | true ];
		implicitMeaning: [ :arg :app | false ])
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> delimiterFlag [

	^ (ClapFlag id: #delimiter)
			description: 'Specifies the table-cell delimiter that delimits listed information attributes.';
			meaning: [ :arg :app | "this argument is optional "
				(arg at: #delimiterArg) value];
			implicitMeaning: [ :arg :app | app implicitDelimiter ];
			add: ((ClapPositional id: #delimiterArg)
					description: 'Delimiter argument for printing, can be one or more characters (without space).';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingDelimiterArgMessage]).
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

{ #category : #logging }
PhLCliCommand class >> missingDelimiterArgMessage [

	^ 'Missing argument value specifying delimiter for printing.'
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

{ #category : #'command line - arguments' }
PhLCliCommand class >> rowModeFlag [

	^ ((ClapFlag id: #rowMode)
		description: 'Prints one attribute per line only.';
		meaning: [ :arg :app | true ];
		implicitMeaning: [ :arg :app | false ])
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> stonFlag [

	^ ((ClapFlag id: #ston)
		description: 'Prints information in STON format.';
		meaning: [ :arg :app | true ];
		implicitMeaning: [ :arg :app | false ])
]

{ #category : #'private ' }
PhLCliCommand >> boolValueFor: flagId [

	^ [(arguments at: flagId) value: self]
		on: NotYetImplemented
		do: [false]
]

{ #category : #'accessing arguments' }
PhLCliCommand >> briefPrint [ 

	^ self boolValueFor:  #brief
]

{ #category : #accessing }
PhLCliCommand >> cliFormatter [

	^ cliFormatter 
]

{ #category : #accessing }
PhLCliCommand >> cliFormatter: aFormatter [

	cliFormatter := aFormatter
]

{ #category : #accessing }
PhLCliCommand >> currentVMPid [

	^ OSSVMProcess vmProcess pid
]

{ #category : #default }
PhLCliCommand >> defaultTemplate [
	self
		findLatestPharoStableVersionIn: self defaultTemplateCategory templatesAndGroups
]

{ #category : #default }
PhLCliCommand >> defaultTemplateCategory [
	^ self templateRepository
		categoryNamed: self defaultTemplateCategoryName
]

{ #category : #default }
PhLCliCommand >> defaultTemplateCategoryName [
	^ 'Official distributions'
]

{ #category : #'accessing arguments' }
PhLCliCommand >> delimiter [ 
	|delimiter|
	delimiter := self flagValueFor: #delimiter.
	delimiter ifNil: [^ self implicitDelimiter  ].
	^ delimiter
]

{ #category : #'private ' }
PhLCliCommand >> errorStream [
	^ errorStream
		ifNil: [ errorStream := VTermOutputDriver on: arguments context stderr ]
]

{ #category : #'command execution' }
PhLCliCommand >> execute [
	^ self context exitSuccess
]

{ #category : #'command execution' }
PhLCliCommand >> executeOSShellCommand [

	^ self executeOSShellCommandWithArgs: self osShellArgArray
]

{ #category : #'command execution' }
PhLCliCommand >> executeOSShellCommandWithArgs: argArray [

^ PhLProcessWrapper new 
		shellCommand;
		addAllArguments: argArray;
		runAndWaitWithStdOutput
]

{ #category : #'private ' }
PhLCliCommand >> filterPrintAttributesFrom: attrCollection [

	"only first (most important) attribute is printed for brief mode by default, can be overriden"
	self briefPrint ifTrue: [ ^ attrCollection copyFrom: 1 to: 1 ].
	^ attrCollection
]

{ #category : #querying }
PhLCliCommand >> findLatestPharoStableVersionIn: aLocation [
	^ (aLocation
		detect: [ :template | 
			(template name includesSubstring: 'stable')
				and: [ template name includesSubstring: '64bit' ] ]) name
]

{ #category : #'private ' }
PhLCliCommand >> flagValueFor: flagId [

	^ [(arguments at: flagId) value: self]
		on: NotYetImplemented
		do: [nil]
]

{ #category : #accessing }
PhLCliCommand >> imageRepository [
	^ self pharoLauncherModel imageRepository
]

{ #category : #'private ' }
PhLCliCommand >> implicitDelimiter [

	^ self rowMode 
	ifTrue: [ ': ' ]
	ifFalse: [ ' ' ]
]

{ #category : #printing }
PhLCliCommand >> list: domainObjects [
	
	self cliFormatter domainObjects: domainObjects.
	self cliFormatter printList.
]

{ #category : #'private ' }
PhLCliCommand >> listPrintAttributeBlocks [

	^ self filterPrintAttributesFrom: self modelClass listPrintAttributeBlocks
	
	
]

{ #category : #'private ' }
PhLCliCommand >> listPrintAttributeLabels [

	^ self filterPrintAttributesFrom: self modelClass listPrintAttributeLabels
	
]

{ #category : #printing }
PhLCliCommand >> logExceptionMessage: errMessage [

	self errorStream nextPutAll: errMessage.
	self errorStream newLine.
]

{ #category : #'private ' }
PhLCliCommand >> modelClass [

 ^ self class environment at: #PhLObject
]

{ #category : #'command execution' }
PhLCliCommand >> osShellArgArray [
	"No OS shell arguments by default, using array instead of string"
	^ #()
]

{ #category : #'private ' }
PhLCliCommand >> outStream [
	^ outStream
		ifNil: [ outStream := VTermOutputDriver on: arguments context stdout ]
]

{ #category : #'accessing arguments' }
PhLCliCommand >> outputAsSton [

	^ self boolValueFor: #ston
]

{ #category : #accessing }
PhLCliCommand >> pharoLauncherModel [
	^ self context launcherModel
]

{ #category : #'accessing arguments' }
PhLCliCommand >> printSequence [

	"by default, print also sequence number for all listing commands"
	^ true
]

{ #category : #'accessing arguments' }
PhLCliCommand >> rowMode [

	^ self boolValueFor: #rowMode
]

{ #category : #initialization }
PhLCliCommand >> setArguments: args [ 
	super setArguments: args.
	PhLNotificationCenter default outStream: self outStream.
	PhLNotificationCenter default errorStream: self errorStream.
	self cliFormatter: (ConsoleListFormatter on: self).
]

{ #category : #initialization }
PhLCliCommand >> setPharoLauncherModel: aPharoLauncherModel [ 
	pharoLauncherModel := aPharoLauncherModel 
]

{ #category : #'accessing arguments' }
PhLCliCommand >> templateName [ 

	^ self flagValueFor: #templateName
	
	
]

{ #category : #accessing }
PhLCliCommand >> templateRepository [ 
	^ self pharoLauncherModel templateRepository
]

{ #category : #accessing }
PhLCliCommand >> vmRepository [
	^ self pharoLauncherModel vmManager availableVirtualMachines
		values
]
