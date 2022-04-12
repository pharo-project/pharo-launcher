Class {
	#name : #PhLVmCliCommandTest,
	#superclass : #PhLCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLVmCliCommandTest >> addVmNamed: vmName [ 
	^ self vmRepository addVmNamed: vmName at: vmName
]

{ #category : #'process actions' }
PhLVmCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model vmManager: PhLVirtualMachinesMockRepo new.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model

]

{ #category : #accessing }
PhLVmCliCommandTest >> vmRepository [ 
	^ self launcherModel vmManager
]
