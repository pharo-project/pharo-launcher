"
Virtual Machine manager for test purposes.
I mock network calls.
"
Class {
	#name : #PhLTestVirtualMachineManager,
	#superclass : #PhLVirtualMachineManager,
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #private }
PhLTestVirtualMachineManager class >> fetch: aVmUrl to: vmName [
	| vmFolder |
	vmFolder := (self vmStore / vmName).
	vmFolder ensureCreateDirectory.
	(vmFolder / 'fetched!') ensureCreateFile.
]

{ #category : #private }
PhLTestVirtualMachineManager class >> vmStore [
	^ vmStore ifNil: [ vmStore := FileSystem memory root ]
]
