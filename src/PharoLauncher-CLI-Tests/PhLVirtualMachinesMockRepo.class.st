"
A ""fake"" repository only usefull for the tests
"
Class {
	#name : #PhLVirtualMachinesMockRepo,
	#superclass : #Object,
	#instVars : [
		'virtualMachines',
		'availableVirtualMachines',
		'id'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLVirtualMachinesMockRepo >> addVmNamed: aVMName at: someDictionaryIndice [ 
	| vm |
	vm := PhLVirtualMachinesMock id:aVMName. 
	availableVirtualMachines at: someDictionaryIndice put: vm.
	^ self
]

{ #category : #accessing }
PhLVirtualMachinesMockRepo >> availableVirtualMachines [
   ^availableVirtualMachines
]

{ #category : #accessing }
PhLVirtualMachinesMockRepo >> availableVirtualMachines: anObject [
   availableVirtualMachines := anObject
]

{ #category : #accessing }
PhLVirtualMachinesMockRepo >> id [ 
   ^self 
]

{ #category : #accessing }
PhLVirtualMachinesMockRepo >> initialize [
	super initialize.
	availableVirtualMachines := Dictionary new
]
