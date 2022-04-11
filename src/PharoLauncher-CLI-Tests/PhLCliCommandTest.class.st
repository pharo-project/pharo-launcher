Class {
	#name : #PhLCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

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

{ #category : #accessing }
PhLCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #'process actions' }
PhLCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]

{ #category : #running }
PhLCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model
]

{ #category : #test }
PhLCliCommandTest >> testBoolValueFor [

	"implicit value of not implemented command bool argument is false"
	| aCommand aMatch|
	
	aCommand :=  PhLCliCommand new.
	aMatch := (context arguments: #('launcher')) doMatch.
	aCommand setArguments: aMatch.
	self deny: (aCommand boolValueFor: #someRandomID).
	
	"help flag should return true"
	aMatch := (context arguments: #('launcher' '--help')) doMatch.
	aCommand setArguments: aMatch.
	self assert: (aCommand boolValueFor: #helpFlag).
]

{ #category : #test }
PhLCliCommandTest >> testExecuteOSShellCommand [

	"nothing is executed"
	self assert: PhLCliCommand new executeOSShellCommand isEmptyOrNil.
	
]

{ #category : #test }
PhLCliCommandTest >> testExecuteOSShellCommandWithArgs [
	|aCmd|
	aCmd := PhLCliCommand new. 
	self deny: (aCmd executeOSShellCommandWithArgs: #('ls')) isEmptyOrNil.
	self should: [aCmd executeOSShellCommandWithArgs: #('bleh')] raise: PhLProcessCommandError description: 'Invoking invalid OS shell command should end up with domain error exception: PHLProcessCommandError'.
]

{ #category : #test }
PhLCliCommandTest >> testFilterPrintAttributesFromShouldReturnCollectionWithFirstElementWhenNoBriefFlag [
	
	| aCommand aMatch|
	
	aCommand :=  PhLCliCommand new.

	context specification add: aCommand class briefFlag.
	aMatch := (context arguments: #('launcher' '--brief')) doMatch.
	aCommand setArguments: aMatch.
	
	self assert: (aCommand filterPrintAttributesFrom: #(1 2 3)) equals: #(1).
]

{ #category : #test }
PhLCliCommandTest >> testFilterPrintAttributesFromShouldReturnOriginalCollectionWhenNoBriefFlag [
	
	| aCommand aMatch|
	
	aCommand :=  PhLCliCommand new.
	aMatch := (context arguments: #('launcher')) doMatch.
	aCommand setArguments: aMatch.
	"filter without brief flag should return original collection"
	self assert: (aCommand filterPrintAttributesFrom: #(1 2 3)) equals: #(1 2 3).
]

{ #category : #test }
PhLCliCommandTest >> testFlagValueFor [

	"implicit value of not implemented/missing flag with parameter should return nil"
	| aCommand aMatch|
	
	aCommand :=  PhLCliCommand new.
	aMatch := (context arguments: #('launcher')) doMatch.
	aCommand setArguments: aMatch.
	self assert: (aCommand flagValueFor: #someRandomID) isNil.
	
	"now implement delimiter flag and test for value"
	context specification add: aCommand class delimiterFlag.
	aMatch := (context arguments: #('launcher' '--delimiter' 'something')) doMatch.
	
	aCommand setArguments: aMatch.
	self assert: (aCommand flagValueFor: #delimiter) equals: 'something'.
]

{ #category : #test }
PhLCliCommandTest >> testImplicitDelimiterIsColonWhenRowModeActibe [

	| aCommand aMatch|
	
	aCommand :=  PhLCliCommand new.
	context specification add: aCommand class rowModeFlag.
	aMatch := (context arguments: #('launcher' '--rowMode')) doMatch.
	aCommand setArguments: aMatch.
	
	self assert: aCommand implicitDelimiter equals: ': '.
]

{ #category : #test }
PhLCliCommandTest >> testImplicitDelimiterIsSpace [

	"implicit value of not implemented/missing flag with parameter should return nil"
	| aCommand aMatch|
	
	aCommand :=  PhLCliCommand new.
	aMatch := (context arguments: #('launcher')) doMatch.
	aCommand setArguments: aMatch.
	self assert: aCommand implicitDelimiter equals: ' '.
]

{ #category : #test }
PhLCliCommandTest >> testIsProductionCommandClass [

	"test whether production classes are correctly set, mock should return false"
	self assert: PhLCliCommand isProductionCommandClass.
	self deny: PhLCliCommandMock isProductionCommandClass.
]

{ #category : #test }
PhLCliCommandTest >> testListPrintAttributeBlocks [
	
	| aCommand aMatch|
	aCommand :=  PhLCliCommand new.
	aMatch := (context arguments: #('launcher')) doMatch.
	aCommand setArguments: aMatch.
	
	"should be empty by on launcher class"
	self assert: aCommand listPrintAttributeBlocks isEmpty
]

{ #category : #test }
PhLCliCommandTest >> testListPrintAttributeLabels [
	
	| aCommand aMatch|
	aCommand :=  PhLCliCommand new.
	aMatch := (context arguments: #('launcher')) doMatch.
	aCommand setArguments: aMatch.
	
	"should be empty by on launcher class"
	self assert: aCommand listPrintAttributeLabels isEmpty
]
