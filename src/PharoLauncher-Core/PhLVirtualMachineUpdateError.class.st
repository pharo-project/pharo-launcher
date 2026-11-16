"
Error raised when a virtual machine could not be updated. The virtual machine is left as it was before the update.

On Windows, the files of a virtual machine running an image cannot be replaced.
"
Class {
	#name : 'PhLVirtualMachineUpdateError',
	#superclass : 'PhLError',
	#instVars : [
		'vm',
		'cause'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLVirtualMachineUpdateError class >> vm: aPhLVirtualMachine cause: anError [

	^ self new
		  setVm: aPhLVirtualMachine cause: anError;
		  yourself
]

{ #category : 'accessing' }
PhLVirtualMachineUpdateError >> longDescription [

	^ '{1} virtual machine could not be updated: {2}
If images are running on it, close them and update again.' format: {
			  vm id.
			  cause messageText }
]

{ #category : 'accessing' }
PhLVirtualMachineUpdateError >> name [

	^ 'VM not updated'
]

{ #category : 'initialization' }
PhLVirtualMachineUpdateError >> setVm: aPhLVirtualMachine cause: anError [

	vm := aPhLVirtualMachine.
	cause := anError
]
