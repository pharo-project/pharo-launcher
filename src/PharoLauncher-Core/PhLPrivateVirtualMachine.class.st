"
I represent a Pharo virtual machine used to determine an image phar version by running it with a VM compatible with its image format.

	ex: 6505 6521 68021

"
Class {
	#name : #PhLPrivateVirtualMachine,
	#superclass : #PhLVirtualMachine,
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #testing }
PhLPrivateVirtualMachine class >> isClassForDirectory: aFileReference private: isPrivateVm [
	^ isPrivateVm
]

{ #category : #querying }
PhLPrivateVirtualMachine >> downloadUrl [
	^ self manager compatibleVmUrls 
		at: self name asInteger
]

{ #category : #accessing }
PhLPrivateVirtualMachine >> vmStore [
	^ self manager privateVmStore
]
