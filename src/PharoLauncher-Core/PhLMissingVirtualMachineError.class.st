"
Error raised when a virtual machine object describes a VM that cannot be found on disk (i.e. executable not found).
"
Class {
	#name : #PhLMissingVirtualMachineError,
	#superclass : #PhLError,
	#instVars : [
		'vm'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #signalling }
PhLMissingVirtualMachineError class >> signalVm: aPhLVirtualMachine [
	^ self new 
		setVm: aPhLVirtualMachine;
		signal
]

{ #category : #private }
PhLMissingVirtualMachineError >> isResumable [ 
	^ true
]

{ #category : #accessing }
PhLMissingVirtualMachineError >> longDescription [
	^ vm id , 
	' virtual machine was not found!'
]

{ #category : #accessing }
PhLMissingVirtualMachineError >> name [
	^ 'Cannot find VM'
]

{ #category : #initialization }
PhLMissingVirtualMachineError >> setVm: aPhlVirtualMachine [
	vm := aPhlVirtualMachine
]
