Class {
	#name : #PhLVmCliCommandTest,
	#superclass : #PhLCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLVmCliCommandTest >> addVmNamed: vmName [ 
	^ self vmRepository addVmNamed: vmName at: vmName
]

{ #category : #running }
PhLVmCliCommandTest >> setUp [

	super setUp.
	context launcherModel vmManager: PhLVirtualMachinesMockRepo new
]

{ #category : #accessing }
PhLVmCliCommandTest >> vmRepository [ 
	^ self launcherModel vmManager
]
