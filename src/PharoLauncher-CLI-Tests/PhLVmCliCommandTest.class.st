Class {
	#name : #PhLVmCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLVmCliCommandTest >> addVmNamed: anImageName at: someDictionaryIndice [
	^ self vmRepository addVmNamed: anImageName at: someDictionaryIndice 
]

{ #category : #accessing }
PhLVmCliCommandTest >> errorString [
	^ context stdio stderr contents utf8Decoded
]

{ #category : #accessing }
PhLVmCliCommandTest >> launcherModel [
	^ context launcherModel 
]

{ #category : #accessing }
PhLVmCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #'process actions' }
PhLVmCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]

{ #category : #'process actions' }
PhLVmCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model vmBaseRepository: PhLVirtualMachinesMockRepo new.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model

]

{ #category : #accessing }
PhLVmCliCommandTest >> vmRepository [ 
	^ self launcherModel vmBaseRepository
]
