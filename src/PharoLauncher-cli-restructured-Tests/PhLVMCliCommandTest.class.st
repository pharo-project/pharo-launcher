Class {
	#name : #PhLVMCliCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'model'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #instance }
PhLVMCliCommandTest >> PhLCliSpecificCommand [
	^ SubclassResponsibility 
]

{ #category : #adding }
PhLVMCliCommandTest >> addVmNamed: anImageName at: someDictionaryIndice [
	^ model vmBaseRepository addVmNamed: anImageName at: someDictionaryIndice 
]

{ #category : #'process actions' }
PhLVMCliCommandTest >> runCommand: args [
	| command  |
	" PhLCliCommand asCliCommand:model"
	command := self PhLCliSpecificCommand. 
	context := command activationWith: args.
	context execute.
	^ command
]

{ #category : #'process actions' }
PhLVMCliCommandTest >> setUp [
	super setUp.
	model := PharoLauncherCLIModel new.
	model vmBaseRepository: PhLVirtualMachinesMockRepo new.
]
