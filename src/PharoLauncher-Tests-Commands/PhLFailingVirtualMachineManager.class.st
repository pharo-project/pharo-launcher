"
Virtual Machine manager for test purposes.
I always fail to fetch a virtual machine.
"
Class {
	#name : 'PhLFailingVirtualMachineManager',
	#superclass : 'PhLTestVirtualMachineManager',
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'private' }
PhLFailingVirtualMachineManager class >> fetch: aVmUrl to: targetFile [

	PhLDownloadError signalUrl: aVmUrl
]

{ #category : 'private' }
PhLFailingVirtualMachineManager class >> vmStore [

	^ superclass vmStore
]
