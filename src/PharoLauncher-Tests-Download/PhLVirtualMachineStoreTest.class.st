"
I am the common superclass of the tests on virtual machines installed in a VM store and published on a server.

The server is replaced by PhLDownloadManagerMock. The VM store is a real temporary folder because archives may be unzipped by a system command.
"
Class {
	#name : 'PhLVirtualMachineStoreTest',
	#superclass : 'TestCase',
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#instVars : [
		'vmStore'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'testing' }
PhLVirtualMachineStoreTest class >> isAbstract [

	^ self = PhLVirtualMachineStoreTest
]

{ #category : 'running' }
PhLVirtualMachineStoreTest >> runCase [
	"The VM store is in place before the set up to never touch the VM store of the user"

	| temporaryStore |
	temporaryStore := (FileLocator temp / ('pharo-launcher-tests-' , UUID new asString)) ensureCreateDirectory.
	vmStore := temporaryStore.
	[ PhLVirtualMachineManager useVmStore: temporaryStore during: [ super runCase ] ]
		ensure: [ temporaryStore ensureDeleteAll ]
]

{ #category : 'helpers' }
PhLVirtualMachineStoreTest >> server [

	^ PhLDownloadManager default
]

{ #category : 'helpers' }
PhLVirtualMachineStoreTest >> serverPublishesArchiveOf: aVm lastModified: aDateAndTime [

	self server
		atUrl: aVm downloadUrl
		answerStamp: (PhLRemoteFileStamp etag: 'any' lastModified: aDateAndTime)
]

{ #category : 'running' }
PhLVirtualMachineStoreTest >> setUp [

	super setUp.
	PhLDownloadManagerMock install
]

{ #category : 'running' }
PhLVirtualMachineStoreTest >> tearDown [

	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : 'accessing' }
PhLVirtualMachineStoreTest >> vmStoreRoot [

	^ vmStore
]
