"
I specify how a virtual machine detects that a newer archive is published on the server, and how it updates itself from it.
"
Class {
	#name : 'PhLVirtualMachineUpdateTest',
	#superclass : 'PhLVirtualMachineStoreTest',
	#instVars : [
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

{ #category : 'helpers' }
PhLVirtualMachineUpdateTest >> serverPublishesArchiveLastModified: aDateAndTime [

	self serverPublishesArchiveOf: vm lastModified: aDateAndTime
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
	vm := PhLVirtualMachine id: '130-x64'
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

{ #category : 'tests' }
PhLVirtualMachineUpdateTest >> testUpdatingAllSkipsVmFailingToUpdate [

	| otherVm errors |
	otherVm := PhLVirtualMachine id: '120-x64'.
	self serverPublishesCorruptedArchiveTagged: 'first'.
	self serverPublishes: (self vmArchiveVersioned: 'first') of: otherVm tagged: 'first'.

	errors := PhLVirtualMachine updateAll: {
			          vm.
			          otherVm }.

	self assert: (vmStore / otherVm id / 'version') contents equals: 'first'.
	self assert: errors size equals: 1.
	self assert: (errors first longDescription includesSubstring: vm id)
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
