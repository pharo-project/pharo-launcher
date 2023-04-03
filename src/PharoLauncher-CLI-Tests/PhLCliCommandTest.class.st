Class {
	#name : #PhLCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #asserting }
PhLCliCommandTest >> assertCommand: commandArgsArray toPrintHelpWith: printHelpString [

	"reset output and check that result of command contains expected print help string"
	self outputReset.
	self runCommand: commandArgsArray.	 
	self assertSuccess.
	self assert: (self outputString includesSubstring: printHelpString).
]

{ #category : #asserting }
PhLCliCommandTest >> assertFailure [
	self deny: context exitStatus equals: 0
]

{ #category : #asserting }
PhLCliCommandTest >> assertSuccess [
	self assert: context exitStatus equals: 0.
	self assert: self errorString equals: ''
]

{ #category : #accessing }
PhLCliCommandTest >> errorString [
	^ context stdio stderr contents utf8Decoded
]

{ #category : #accessing }
PhLCliCommandTest >> launcherModel [
	^ context launcherModel 
]

{ #category : #resetting }
PhLCliCommandTest >> outputReset [
	"this is for test purposes only, to have clear output, when asserting contents"
	context stdio stdout resetContents
]

{ #category : #accessing }
PhLCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #printing }
PhLCliCommandTest >> printValidationReportFor: args [

	|report|
	context arguments: args; match.
	report := context allValidations.
	context allValidations isSuccess ifTrue: [ ^ '' ].
	^ String streamContents: [:aStream | 
		(ClapValidationErrorPrinter on: report) printOn: aStream].
]

{ #category : #'process actions' }
PhLCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]

{ #category : #running }
PhLCliCommandTest >> setUp [

	super setUp.
	context := PhLCliCommand launcherCommand activation
]

{ #category : #tests }
PhLCliCommandTest >> testExecuteLauncherCommandToPrintHelp [
	|expectedPrintout|
	expectedPrintout := 'This is command line interface of Pharo Launcher'.
	
	self assertCommand: #('launcher') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'help') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' '--help') toPrintHelpWith: expectedPrintout.

]

{ #category : #tests }
PhLCliCommandTest >> testExecuteOSShellCommand [

	"nothing is executed"
	self assert: PhLCliCommand new executeOSShellCommand isEmptyOrNil.
	
]

{ #category : #tests }
PhLCliCommandTest >> testExecuteOSShellCommandWithArgs [
	|aCmd|
	aCmd := PhLCliCommand new. 
	self deny: (aCmd executeOSShellCommandWithArgs: #('ls')) isEmptyOrNil.
	self should: [aCmd executeOSShellCommandWithArgs: #('bleh')] raise: PhLProcessCommandError description: 'Invoking invalid OS shell command should end up with domain error exception: PHLProcessCommandError'.
]

{ #category : #tests }
PhLCliCommandTest >> testFilterPrintAttributesFromShouldReturnCollectionWithFirstElementWhenBriefFlagEnabled [
	
	| aCommand cmdSpec|
	
	cmdSpec := PhLCliCommand asCliCommand.
	PhLCliCommand addBriefFlagTo: cmdSpec.
	aCommand := (cmdSpec activationWith: #('launcher' '--brief')) command.

	self assert: (aCommand filterPrintAttributesFrom: #(1 2 3)) equals: #(1).
]

{ #category : #tests }
PhLCliCommandTest >> testFilterPrintAttributesFromShouldReturnOriginalCollectionWhenNoBriefFlag [
	
	| aCommand |
	
	aCommand := (PhLCliCommand asCliCommand activationWith: #('launcher' )) command.

	"filter without brief flag should return original collection"
	self assert: (aCommand filterPrintAttributesFrom: #(1 2 3)) equals: #(1 2 3).
]

{ #category : #tests }
PhLCliCommandTest >> testHasFlag [

	"implicit value of not implemented command bool argument is false"
	| aCommand |
	aCommand := (PhLCliCommand asCliCommand activationWith: #('launcher' '--help')) command.
	self deny: (aCommand hasFlag: #someRandomID).
	
	"help flag should return true"
	self assert: (aCommand hasFlag: #help).
]

{ #category : #tests }
PhLCliCommandTest >> testImplicitDelimiterIsColonWhenRowModeActive [
	
	| aCommand cmdSpec|
	
	cmdSpec := PhLCliCommand asCliCommand.
	PhLCliCommand addRowModeFlagTo: cmdSpec.
	aCommand := (cmdSpec activationWith: #('launcher' '--rowMode')) command.
	"when using row mode, implicit delimiter should be colon with space"
	self assert: aCommand implicitDelimiter equals: ': '.
]

{ #category : #tests }
PhLCliCommandTest >> testImplicitDelimiterIsSpace [
	
	| aCommand |
	aCommand := (PhLCliCommand asCliCommand activationWith: #('launcher' )) command.
	"when column mode is used, implicit delimiter is space"
	self assert: aCommand implicitDelimiter equals: ' '.
]

{ #category : #tests }
PhLCliCommandTest >> testIsProductionCommandClass [

	"test whether production classes are correctly set, mock should return false"
	self assert: PhLCliCommand isProductionCommandClass.
	self deny: PhLCliCommandMock isProductionCommandClass.
]

{ #category : #tests }
PhLCliCommandTest >> testListPrintAttributeBlocks [
	
	| aCommand |
	aCommand := (PhLCliCommand asCliCommand activationWith: #('launcher' )) command.
	
	"should be empty by on launcher class"
	self assert: aCommand listPrintAttributeBlocks isEmpty
]

{ #category : #tests }
PhLCliCommandTest >> testListPrintAttributeLabels [
	
	| aCommand |	
	aCommand := (PhLCliCommand asCliCommand activationWith: #('launcher' )) command.

	"should be empty by on launcher class"
	self assert: aCommand listPrintAttributeLabels isEmpty
]

{ #category : #tests }
PhLCliCommandTest >> testPositionalWithValue [

	"implicit value of not implemented/missing flag with parameter should return nil"
	| aCommand cmdSpec |

	cmdSpec := PhLCliCommand asCliCommand.
	aCommand := (cmdSpec activationWith: #('launcher')) command.
	
	self should: [aCommand positional: #someRandomID] raise: NotFound description: 'Exception expected when asking positional for unknown flag'.
	
	"now implement delimiter flag and test for value"
	PhLCliCommand addDelimiterFlagTo: cmdSpec.
	aCommand := (cmdSpec activationWith: #('launcher' '--delimiter' 'something')) command.
	self assert: (aCommand positional: #delimiter) equals: 'something'.
	
	"now test - when value is not present"
	aCommand := (cmdSpec activationWith: #('launcher' '--delimiter')) command.
	self assert: (aCommand positional: #delimiter) isNil.
]
