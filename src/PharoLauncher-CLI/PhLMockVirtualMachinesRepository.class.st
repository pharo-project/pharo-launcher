Class {
	#name : #PhLMockVirtualMachinesRepository,
	#superclass : #Object,
	#instVars : [
		'virtualMachines',
		'availableVirtualMachines'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #accessing }
PhLMockVirtualMachinesRepository >> availableVirtualMachines [
   ^availableVirtualMachines
]

{ #category : #accessing }
PhLMockVirtualMachinesRepository >> availableVirtualMachines: anObject [
   availableVirtualMachines := anObject
]
