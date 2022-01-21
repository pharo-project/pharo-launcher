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
		'errorStream'
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

{ #category : #'accessing arguments' }
PhLCliCommand >> briefPrint [ 

	^ (arguments at: #brief) value
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
	
	^ (arguments at: #delimiter)
		value: self
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
PhLCliCommand >> getColumnWidthsFrom: domainObjects [
	|aLabels|
	"get max column width either from column label or value in column"
	aLabels := self listPrintAttributeLabels.
	^ 	self listPrintAttributeBlocks withIndexCollect: [:attrBlock :idx| 
			(domainObjects getMaxWithOn: attrBlock) max: (aLabels at: idx) size
		]
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
	
	domainObjects isEmpty ifTrue: [ ^ self ].
	self rowMode 
	ifTrue: [ self printOneAttrPerRow: domainObjects]
	ifFalse: [self printAttributeTableFrom: domainObjects ]
]

{ #category : #printing }
]

{ #category : #printing }
PhLCliCommand >> listAsSton: aCollection [
	self outStream nextPutAll: (STON toString: aCollection) 
]

{ #category : #printing }
PhLCliCommand >> logExceptionMessage: errMessage [

	self errorStream nextPutAll: errMessage.
	self errorStream newLine.
]

{ #category : #'private ' }
PhLCliCommand >> listPrintAttributeBlocks [

	^self filterPrintAttributesFrom:  self modelClass listPrintAttributeBlocks
	
	
]

{ #category : #'private ' }
PhLCliCommand >> listPrintAttributeLabels [

	^ self filterPrintAttributesFrom:  self modelClass listPrintAttributeLabels
	
]

{ #category : #message }
PhLCliCommand >> messageErrorCategoryNotFound [
	self errorStream nextPutAll: 'please enter a correct category '.
	self errorStream newLine.
	^ self
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
	^ (arguments at: #ston) value: self
]

{ #category : #accessing }
PhLCliCommand >> pharoLauncherModel [
	^ self context launcherModel
]

{ #category : #printing }
PhLCliCommand >> printAttributeHeaders: aLabels by: colWidths [

	"print header labels and header line"
	self printCell: '#' width: 2.
	self printDelimiter.
	self printRowValues: aLabels by: colWidths. 
	self printHeaderLinesBy: colWidths.
]

{ #category : #printing }
PhLCliCommand >> printAttributeRows: domainObjects by: colWidths [

	|blockArray|
	blockArray := self listPrintAttributeBlocks.
	domainObjects withIndexDo: [:listedObject :idx|
		|aValues|
		self printCell: idx asString width: 2.
		self printDelimiter.
		aValues := blockArray collect: [:aBlock | aBlock value: listedObject ].
		self printRowValues: aValues by: colWidths		
	]
]

{ #category : #printing }
PhLCliCommand >> printAttributeTableFrom: domainObjects [	

		|colWidths |
		colWidths := self getColumnWidthsFrom: domainObjects.
		"no header if brief print is enabled"
		self briefPrint ifFalse: [self printAttributeHeaders: self listPrintAttributeLabels by: colWidths].
		self printAttributeRows: domainObjects by: colWidths.

]

{ #category : #printing }
PhLCliCommand >> printCell: aString width: widthSize [

	self outStream nextPutAll: (aString padRightTo: widthSize)

]

{ #category : #printing }
PhLCliCommand >> printDelimiter [

	self outStream nextPutAll: self delimiter
]

{ #category : #printing }
PhLCliCommand >> printHeaderLinesBy: colWidths [

	"print header line"
	self printLineSized: 2.
	self printDelimiter.
	colWidths do: [:aWidth | self printLineSized: aWidth.
		self printDelimiter].
	self outStream newLine.
]

{ #category : #printing }
PhLCliCommand >> printLineSized: aWidth [ 

	self outStream nextPutAll: ('' padLeftTo: aWidth with: $-)
]

{ #category : #printing }
PhLCliCommand >> printOneAttrPerRow: domainObjects [

	|blockArray aLabels|
	blockArray := self listPrintAttributeBlocks.
	aLabels := self listPrintAttributeLabels. 
	domainObjects withIndexDo: [:listedObject :idx|

		self printRowValues: { 'Nr.'. idx asString. } by: { 0. 2. }.
		aLabels withIndexDo: [:attrLabel :attrIdx |
		self printRowValues: { attrLabel. (blockArray at: attrIdx) value: listedObject. } by: { 0. 0. }.
		].
		self outStream newLine.
	]
]

{ #category : #printing }
PhLCliCommand >> printRowValues: aStringColl by: colWidths [

	"print string values by column widths"
	aStringColl withIndexDo: [:aLabel :idx |
		self printCell: aLabel width: (colWidths at: idx).
		idx = aStringColl size ifFalse: [ self printDelimiter].
	].
	self outStream newLine.
]

{ #category : #'accessing arguments' }
PhLCliCommand >> rowMode [

	^ (arguments at: #rowMode) value
]

{ #category : #initialization }
PhLCliCommand >> setArguments: args [ 
	super setArguments: args.
	PhLNotificationCenter default outStream: self outStream.
	PhLNotificationCenter default errorStream: self errorStream.
]

{ #category : #initialization }
PhLCliCommand >> setPharoLauncherModel: aPharoLauncherModel [ 
	pharoLauncherModel := aPharoLauncherModel 
]

{ #category : #'accessing arguments' }
PhLCliCommand >> templateName [ 
	^ (arguments at: #templateName) value: self.
	
	
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
