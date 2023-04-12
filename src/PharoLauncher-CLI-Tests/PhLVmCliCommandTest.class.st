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
	self launcherModel vmManager: PhLVirtualMachinesMockRepo new
]

{ #category : #tests }
PhLVmCliCommandTest >> testExecuteLauncherVMCommandToPrintHelp [
	|expectedPrintout|
	expectedPrintout := 'Usage: launcher vm'.
	
	self assertCommand: #('launcher' 'vm') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'vm' 'help') toPrintHelpWith: expectedPrintout.
	self assertCommand: #('launcher' 'vm' '--help') toPrintHelpWith: expectedPrintout.

]

{ #category : #accessing }
PhLVmCliCommandTest >> vmRepository [ 
	^ self launcherModel vmManager
]
