Class {
	#name : #PhLVirtualMachinesMockRepo,
	#superclass : #Object,
	#instVars : [
		'virtualMachines',
		'availableVirtualMachines',
		'id'
	],
	#category : #'PharoLauncher-CLI-New'
}

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
