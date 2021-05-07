"
Usefull only to run the tests. Indeed each users have not the same Images on their drive so we create a ""fake directory"" containing fake ""images"" on prder to always have the same tests.
"
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
