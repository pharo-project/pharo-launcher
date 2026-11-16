"
I specify how a virtual machine detects that a newer archive is published on the server, and how it updates itself from it.

The server is replaced by PhLDownloadManagerMock. The VM store is a real temporary folder because archives may be unzipped by a system command.
"
Class {
	#name : 'PhLVirtualMachineUpdateTest',
	#superclass : 'TestCase',
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#instVars : [
		'vmStore',
		'vm'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> installVmWithoutStamp [
	"A VM installed before the Launcher recorded the stamp of VM archives"

	self createVmNamed: vm id.
	vm := PhLVirtualMachine id: vm id
]

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> installedVersion [

	^ (vmStore / vm id / 'version') contents
]

{ #category : 'running' }
PhLVirtualMachineUpdateTest >> runCase [
	"The VM store is in place before the set up to never touch the VM store of the user"

	| temporaryStore |
	temporaryStore := (FileLocator temp / ('pharo-launcher-tests-' , UUID new asString)) ensureCreateDirectory.
	vmStore := temporaryStore.
	[ PhLVirtualMachineManager useVmStore: temporaryStore during: [ super runCase ] ]
		ensure: [ temporaryStore ensureDeleteAll ]
]

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> server [

	^ PhLDownloadManager default
]

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> serverPublishesArchiveLastModified: aDateAndTime [

	self server
		atUrl: vm downloadUrl
		answerStamp: (PhLRemoteFileStamp etag: 'any' lastModified: aDateAndTime)
]

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> serverPublishes: anArchive of: aVm tagged: anETag [

	self server
		atUrl: aVm downloadUrl answer: anArchive;
		atUrl: aVm downloadUrl answerStamp: (PhLRemoteFileStamp etag: anETag)
]

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> serverPublishesArchiveTagged: anETag [

	self serverPublishes: (self vmArchiveVersioned: anETag) of: vm tagged: anETag
]

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> serverPublishesCorruptedArchiveTagged: anETag [
	"The first entries of the archive can be extracted, not the last one"

	| archive |
	archive := self vmArchiveVersioned: anETag.
	archive
		at: (archive indexOfSubCollection: PhLVirtualMachine elfMagicNumber startingAt: 1)
		put: 0.
	self serverPublishes: archive of: vm tagged: anETag
]

{ #category : 'running' }
PhLVirtualMachineUpdateTest >> setUp [

	super setUp.
	PhLDownloadManagerMock install.
	vm := PhLVirtualMachine id: '130-x64'
]

{ #category : 'running' }
PhLVirtualMachineUpdateTest >> tearDown [

	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testFailedUpdateKeepsInstalledVm [

	self serverPublishesArchiveTagged: 'first'.
	vm updateFromUrl.
	self serverPublishesCorruptedArchiveTagged: 'second'.

	self should: [ vm updateFromUrl ] raise: Error.

	self assert: vm isValid.
	self assert: self installedVersion equals: 'first'.
	self assert: vm isUpdateAvailable.
	self assert: vmStore directoryNames asArray equals: { vm id }
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testNoUpdateIsAvailableForVmNotInstalled [

	self serverPublishesArchiveTagged: 'first'.

	self deny: vm isUpdateAvailable
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testNoUpdateIsAvailableRightAfterUpdating [

	self serverPublishesArchiveTagged: 'first'.

	vm updateFromUrl.

	self deny: vm isUpdateAvailable
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testNoUpdateIsAvailableForVmWithoutStampWhenServerArchiveIsOlder [

	self installVmWithoutStamp.

	self serverPublishesArchiveLastModified: DateAndTime now - 1 day.

	self deny: vm isUpdateAvailable
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testNoUpdateIsAvailableWhenServerDoesNotAnswer [

	self installVmWithoutStamp.

	self deny: vm isUpdateAvailable
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testUpdateIsAvailableForVmWithoutStampWhenServerArchiveIsNewer [

	self installVmWithoutStamp.

	self serverPublishesArchiveLastModified: DateAndTime now + 1 day.

	self assert: vm isUpdateAvailable
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testUpdateIsAvailableWhenServerPublishesNewArchive [

	self serverPublishesArchiveTagged: 'first'.
	vm updateFromUrl.

	self serverPublishesArchiveTagged: 'second'.

	self assert: vm isUpdateAvailable
]

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testUpdateKeepsFilesTheArchiveDoesNotProvide [
	"e.g. the sources files fetched for old Pharo versions"

	| sourcesFile |
	self serverPublishesArchiveTagged: 'first'.
	vm updateFromUrl.
	sourcesFile := (vmStore / vm id / 'PharoV60.sources') ensureCreateFile.
	self serverPublishesArchiveTagged: 'second'.

	vm updateFromUrl.

	self assert: sourcesFile exists.
	self assert: self installedVersion equals: 'second'
]

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> vmArchiveVersioned: aString [
	"A zip archive with the VM executables expected on OS X and Linux"

	| archive |
	archive := ZipArchive new.
	archive addString: aString asByteArray as: 'version'.
	archive addString: 'vm' asByteArray as: 'Pharo.app/Contents/MacOS/Pharo'.
	archive addString: PhLVirtualMachine elfMagicNumber as: 'pharo'.
	^ ByteArray streamContents: [ :stream | archive writeTo: stream ]
]

{ #category : 'accessing' }
PhLVirtualMachineUpdateTest >> vmStoreRoot [

	^ vmStore
]
