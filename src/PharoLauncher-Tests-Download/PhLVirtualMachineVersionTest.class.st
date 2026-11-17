"
I specify how a virtual machine tells its version: the one printed by its executable.
"
Class {
	#name : 'PhLVirtualMachineVersionTest',
	#superclass : 'PhLVirtualMachineStoreTest',
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLVirtualMachineVersionTest >> installVmPrinting: aString [
	"Install a VM whose executable is a script printing the given text"

	| vm |
	OSPlatform current isWindows ifTrue: [ ^ self skip ].
	self createVmNamed: '130-x64'.
	vm := PhLVirtualMachine id: '130-x64'.
	self makeExecutableOf: vm print: aString.
	^ vm
]

{ #category : 'helpers' }
PhLVirtualMachineVersionTest >> storeVersion: aString of: aVm executableTime: aDateAndTime [

	| folder |
	folder := vmStore / aVm id.
	(PhLVmMetadata inFolder: folder)
		recordVersion: aString executableTime: aDateAndTime;
		storeInFolder: folder
]

{ #category : 'helpers' }
PhLVirtualMachineVersionTest >> storedMetadataOf: aVm [

	^ PhLVmMetadata inFolder: vmStore / aVm id
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testCheckForUpdateStoresTheVersion [
	"The server does not answer: the version is stored anyway"

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026'.

	vm checkForUpdate.

	self assert: (self storedMetadataOf: vm) version equals: '10.3.12'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testReadingTheVersionDoesNotStoreIt [
	"Only checks and installations write the metadata of a VM"

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026'.

	self assert: vm version equals: '10.3.12'.

	self assert: (self storedMetadataOf: vm) version isNil.
	self assert: vm storedVersion equals: ''
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testRefreshDoesNotRunAnUnchangedExecutable [

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026'.
	self storeVersion: '9.9.9' of: vm executableTime: vm lastUpdateTime.

	vm refreshVersion.

	self assert: vm storedVersion equals: '9.9.9'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testRefreshRunsAChangedExecutable [

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026'.
	self storeVersion: '9.9.9' of: vm executableTime: vm lastUpdateTime - 1 day.

	vm refreshVersion.

	self assert: vm storedVersion equals: '10.3.12'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testRefreshStoresTheVersion [

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026'.

	vm refreshVersion.

	self assert: (self storedMetadataOf: vm) version equals: '10.3.12'.
	self assert: vm storedVersion equals: '10.3.12'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testStoredVersionIsReusedWhileExecutableIsUnchanged [
	"Running the executable to get the version takes time"

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026'.

	self storeVersion: '9.9.9' of: vm executableTime: vm lastUpdateTime.

	self assert: vm version equals: '9.9.9'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testUnknownVersionIsNotStored [
	"It is read again at the next check, e.g. once reading the version works on this platform"

	| vm |
	vm := self installVmPrinting: 'Usage: pharo [<option>...] [<imageName> [<argument>...]]'.

	vm refreshVersion.

	self assert: (self storedMetadataOf: vm) version isNil
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionIsEmptyWhenExecutableCannotBeRun [

	self createVmNamed: '130-x64'.

	self assert: (PhLVirtualMachine id: '130-x64') version equals: ''
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionIsEmptyWhenExecutableDoesNotPrintAVersion [

	| vm |
	vm := self installVmPrinting: 'Usage: pharo [<option>...] [<imageName> [<argument>...]]'.

	self assert: vm version equals: ''
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionIsReadAgainWhenExecutableChanged [

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026'.

	self storeVersion: '9.9.9' of: vm executableTime: vm lastUpdateTime - 1 day.

	self assert: vm version equals: '10.3.12'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionIsTheOnePrintedByTheExecutable [

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026 12:16:05 Compiler: Apple LLVM 12.0.5'.

	self assert: vm version equals: '10.3.12'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionOfVmNotPrintingItsNameFirst [
	"VMs until Pharo 8"

	| vm |
	vm := self installVmPrinting: '5.0 5.0.202002121007 Mac OS X built on Feb 12 2020 10:23:42 UTC'.

	self assert: vm version equals: '5.0.202002121007'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionWithoutPrefix [
	"VMs of Pharo 9 and 10"

	| vm |
	vm := self installVmPrinting: 'Pharo 9.0.22 built on Mar 30 2023 13:06:13 Compiler: Apple LLVM 12.0.5'.

	self assert: vm version equals: '9.0.22'
]
