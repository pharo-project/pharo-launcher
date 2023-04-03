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

{ #category : #'command line - arguments' }
PhLCliCommand class >> addBriefFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #brief 
		description: 'Prints only name attribute (with leading sequence number).'.
	

"
	^ ((ClapFlag id: #brief)
		description: 'Prints only name attribute (with leading sequence number).';
		meaning: [ :arg :app | true ];
		implicitMeaning: [ :arg :app | false ])"
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> addDelimiterFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #delimiter 
		description: 'Specifies the table-cell delimiter that delimits listed information attributes.' 
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app implicitDelimiter ] ]
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	"No positionals on root spec class 
	 use on subclasses e.g.: aCommandSpec addFlag: #someFlag
	"
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	"No positionals on root spec class 
	 use on subclasses e.g.: aCommandSpec addPositional: #somePositonal
	"
]

{ #category : #'command line - subcommands' }
PhLCliCommand class >> addLauncherSubcommandsTo: aCommandSpec [

	aCommandSpec addAll: (self productionCommandSubclasses collect: #asCliCommand)
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> addPrintFlagsTo: aCommandSpec [
	
	self addBriefFlagTo: aCommandSpec.
	self addRowModeFlagTo: aCommandSpec.
	self addDelimiterFlagTo: aCommandSpec.
	self addStonFlagTo: aCommandSpec.

]

{ #category : #'command line - arguments' }
PhLCliCommand class >> addRowModeFlagTo: aCommandSpec [
	
	aCommandSpec 
		addFlag: #rowMode 
		description: 'Prints one attribute per line only.'
]

{ #category : #'command line - arguments' }
PhLCliCommand class >> addStonFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #ston 
		description: 'Prints information in STON format.'
]

{ #category : #'command line - converting' }
PhLCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #launcher 
]

{ #category : #'private - testing' }
PhLCliCommand class >> isProductionCommandClass [
	
	"use this when command subclass is visible and representable to user, should return false for non-production command classses like abstract classes or mock classes inheriting from this class"
	^ true
]

{ #category : #'command line - description' }
PhLCliCommand class >> launcherCmdDescription [
	^ 'This is command line interface of Pharo Launcher. Create Pharo image from remote site template, lauch Pharo, eventually delete image, update VMs, etc.'
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
	|commandSpec|
	commandSpec := (PhLClapCommandSpec id: idOfCommand)
		description: self launcherCmdDescription;
		commandClass: self;
		addHelp;
		yourself.
	"add subcommands, positionals, flags, depending on subclass"
	self addLauncherSubcommandsTo: commandSpec.
	self addLauncherPositionalsTo: commandSpec.
	self addLauncherFlagsTo: commandSpec.

	^ commandSpec
]

{ #category : #'command line - subcommands' }
PhLCliCommand class >> productionCommandSubclasses [

	^ self subclasses select: #isProductionCommandClass 
]

{ #category : #'error signalling' }
PhLCliCommand class >> raiseMissingDelimiter [

	^ NotFound signal: 'Missing argument value specifying delimiter for printing.'
]

{ #category : #'command execution' }
PhLCliCommand >> basicExecute [
	
	"should be implemented on all sub-classed commands that have business logic, otherwise will print just help"
	self printHelp
]

{ #category : #'accessing arguments' }
PhLCliCommand >> briefPrint [ 

	^ self hasFlag: #brief
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

	(self hasFlag: #delimiter) ifFalse: [ ^ self implicitDelimiter ].
	^ self positional: #delimiter
]

{ #category : #private }
PhLCliCommand >> errorStream [
	"using VTermOutputDriver will help us to use colors and other formatting"
	^ errorStream
		ifNil: [ errorStream := VTermOutputDriver on: self context stderr ]
]

{ #category : #'command execution' }
PhLCliCommand >> execute [
	
	[ self basicExecute ]
	on: NotFound, PhLError
	do: [:ex | 
		self logExceptionMessage: ex printString. 
		self context exitFailure
	]
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

{ #category : #private }
PhLCliCommand >> filterPrintAttributesFrom: attrCollection [

	"only first (most important) attribute is printed for brief mode by default, can be overriden"
	self briefPrint ifTrue: [ ^ attrCollection copyFrom: 1 to: 1 ].
	^ attrCollection
]

{ #category : #querying }
PhLCliCommand >> findLatestPharoStableVersionIn: aTemplateGroup [
	^ aTemplateGroup latestStableTemplate
]

{ #category : #accessing }
PhLCliCommand >> imageRepository [
	^ self pharoLauncherModel imageRepository
]

{ #category : #private }
PhLCliCommand >> implicitDelimiter [
	^ self rowMode
		ifTrue: [ ': ' ]
		ifFalse: [ ' ' ]
]

{ #category : #initialization }
PhLCliCommand >> initialize [
	super initialize.
	self cliFormatter: (ConsoleListFormatter on: self).
]

{ #category : #printing }
PhLCliCommand >> list: domainObjects [
	
	self cliFormatter 
		domainObjects: domainObjects;
		printList.
]

{ #category : #private }
PhLCliCommand >> listPrintAttributeBlocks [

	^ self filterPrintAttributesFrom: self modelClass listPrintAttributeBlocks
	
	
]

{ #category : #private }
PhLCliCommand >> listPrintAttributeLabels [

	^ self filterPrintAttributesFrom: self modelClass listPrintAttributeLabels
	
]

{ #category : #printing }
PhLCliCommand >> logExceptionMessage: errMessage [

	self errorStream nextPutAll: errMessage.
	self errorStream newLine.
]

{ #category : #printing }
PhLCliCommand >> logInfoMessage: aMessage [

	self outStream nextPutAll: aMessage.
	self outStream newLine.
]

{ #category : #private }
PhLCliCommand >> modelClass [

 ^ self class environment at: #PhLObject
]

{ #category : #'command execution' }
PhLCliCommand >> osShellArgArray [
	"No OS shell arguments by default, using array instead of string"
	^ #()
]

{ #category : #private }
PhLCliCommand >> outStream [
	"using VTermOutputDriver will help us to use colors and other formatting"
	^ outStream
		ifNil: [ outStream := VTermOutputDriver on: self context stdout ]
]

{ #category : #'accessing arguments' }
PhLCliCommand >> outputAsSton [

	^ self hasFlag: #ston
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

	^ self hasFlag: #rowMode
]

{ #category : #'accessing arguments' }
PhLCliCommand >> templateName [ 

	^ self positional: #templateName
	
	
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
