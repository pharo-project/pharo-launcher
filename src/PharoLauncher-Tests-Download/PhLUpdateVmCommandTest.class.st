"
I specify which selected virtual machines the Update command of the VM manager updates.

The server is replaced by PhLDownloadManagerMock: it publishes an archive newer or older than the installed VMs.
"
Class {
	#name : 'PhLUpdateVmCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'command'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLUpdateVmCommandTest >> installedVmNamed: aName publishedOnServer: aDateAndTime [

	| vm |
	presenter createVmNamed: aName.
	vm := presenter vmFor: aName.
	PhLDownloadManager default
		atUrl: vm downloadUrl
		answerStamp: (PhLRemoteFileStamp etag: 'any' lastModified: aDateAndTime).
	^ vm
]

{ #category : 'asserting' }
PhLUpdateVmCommandTest >> isUpdated: aVm [

	^ (aVm vmStore / aVm name / 'fetched!') exists
]

{ #category : 'helpers' }
PhLUpdateVmCommandTest >> outdatedVmNamed: aName [

	^ self installedVmNamed: aName publishedOnServer: DateAndTime now + 1 day
]

{ #category : 'running' }
PhLUpdateVmCommandTest >> setUp [

	super setUp.
	PhLDownloadManagerMock install.
	presenter := PhLTestVmPresenter new.
	command := PhLUpdateVmCommand new.
	command context: presenter
]

{ #category : 'running' }
PhLUpdateVmCommandTest >> tearDown [

	PhLTestVirtualMachineManager reset.
	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : 'tests' }
PhLUpdateVmCommandTest >> testMissingVmIsInstalled [

	| missingVm |
	missingVm := PhLVirtualMachine new
		             id: '110-x64';
		             manager: PhLTestVirtualMachineManager new;
		             yourself.
	presenter selection: { missingVm }.

	command execute.

	self assert: (self isUpdated: missingVm)
]

{ #category : 'tests' }
PhLUpdateVmCommandTest >> testOutdatedVmsAreUpdated [

	| vms |
	vms := {
		       (self outdatedVmNamed: '100-x64').
		       (self outdatedVmNamed: '90-x64') }.
	presenter selection: vms.

	command execute.

	self assert: (vms allSatisfy: [ :vm | self isUpdated: vm ]).
	self assert: presenter information isNil
]

{ #category : 'tests' }
PhLUpdateVmCommandTest >> testUpToDateVmIsSkippedAndReported [

	| upToDateVm outdatedVm |
	upToDateVm := self upToDateVmNamed: '100-x64'.
	outdatedVm := self outdatedVmNamed: '90-x64'.
	presenter selection: {
			upToDateVm.
			outdatedVm }.

	command execute.

	self deny: (self isUpdated: upToDateVm).
	self assert: (self isUpdated: outdatedVm).
	self assert: (presenter information message includesSubstring: 'up to date: 100-x64')
]

{ #category : 'tests' }
PhLUpdateVmCommandTest >> testVmFailingToUpdateIsSkippedAndReported [

	| failingVm otherVm |
	failingVm := self outdatedVmNamed: '100-x64'.
	failingVm manager: PhLFailingVirtualMachineManager new.
	otherVm := self outdatedVmNamed: '90-x64'.
	presenter selection: {
			failingVm.
			otherVm }.

	command execute.

	self deny: (self isUpdated: failingVm).
	self assert: (self isUpdated: otherVm).
	self assert: (presenter information message includesSubstring: '100-x64 virtual machine could not be updated')
]

{ #category : 'helpers' }
PhLUpdateVmCommandTest >> upToDateVmNamed: aName [

	^ self installedVmNamed: aName publishedOnServer: DateAndTime now - 1 day
]
