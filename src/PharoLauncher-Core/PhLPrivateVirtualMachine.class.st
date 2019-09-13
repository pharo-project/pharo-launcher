"
I represent a Pharo virtual machine used to determine an image phar version by running it with a VM compatible with its image format.

	ex: 6505 6521 68021

"
Class {
	#name : #PhLPrivateVirtualMachine,
	#superclass : #PhLVirtualMachine,
	#category : 'PharoLauncher-Core-Download'
}

{ #category : #querying }
PhLPrivateVirtualMachine >> downloadUrl [
	^ PhLVirtualMachineManager new compatibleVmUrls at: self name asInteger
]

{ #category : #accessing }
PhLPrivateVirtualMachine >> vmStore [
	^ vmStore ifNil: [ PhLVirtualMachineManager privateVmStore ]
]
