Class {
	#name : #PhLVirtualMachineCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #tests }
PhLVirtualMachineCommandTest >> testDeleteVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='delete'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testExecuteCommandListVMs [
	| command output |
	command := PhLVirtualMachinesCommand new.
	

]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testInfoVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='info'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testListVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='list'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testUpdateVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='update'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]
