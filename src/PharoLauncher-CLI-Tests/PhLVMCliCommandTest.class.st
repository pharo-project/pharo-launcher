Class {
	#name : #PhLVMCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #instance }
PhLVMCliCommandTest >> PhLCliSpecificCommand [
	^ SubclassResponsibility 
]

{ #category : #adding }
PhLVMCliCommandTest >> addVmNamed: anImageName at: someDictionaryIndice [
	^ self vmRepository addVmNamed: anImageName at: someDictionaryIndice 
]

{ #category : #accessing }
PhLVMCliCommandTest >> launcherModel [
	^ context launcherModel 
]

{ #category : #accessing }
PhLVMCliCommandTest >> outputString [
	^ context stdio stdout contents utf8Decoded
]

{ #category : #'process actions' }
PhLVMCliCommandTest >> runCommand: args [
	^ (context arguments: args) execute.
]

{ #category : #'process actions' }
PhLVMCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model vmBaseRepository: PhLVirtualMachinesMockRepo new.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model

]

{ #category : #accessing }
PhLVMCliCommandTest >> vmRepository [ 
	^ self launcherModel vmBaseRepository
]
