"
I specify how the VM manager shows the version of virtual machines and their status.
The status is the result of the last check for updates, stored with each virtual machine: the VM manager never asks the server.

The VM store is a real temporary folder to be able to run the executable of virtual machines.
"
Class {
	#name : 'PhLVMPresenterUpdateTest',
	#superclass : 'TestCase',
	#instVars : [
		'vmStore',
		'presenter',
		'outdatedVm',
		'upToDateVm',
		'vms'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLVMPresenterUpdateTest >> serverPublishesArchiveOf: aVm lastModified: aDateAndTime [

	PhLDownloadManager default
		atUrl: aVm downloadUrl
		answerStamp: (PhLRemoteFileStamp etag: 'any' lastModified: aDateAndTime)
]

{ #category : 'running' }
PhLVMPresenterUpdateTest >> setUp [

	super setUp.
	PhLDownloadManagerMock install.
	vmStore := FileLocator temp / ('pharo-launcher-tests-' , UUID new asString).
	PhLTestVirtualMachineManager vmStore: vmStore.
	presenter := PhLTestVmPresenter new.
	presenter
		createVmNamed: '100-x64';
		createVmNamed: '90-x64'.
	outdatedVm := presenter vmFor: '100-x64'.
	upToDateVm := presenter vmFor: '90-x64'.
	vms := OrderedCollection with: outdatedVm with: upToDateVm.
	presenter model: (PhLVirtualMachinesDataSource vmsBlock: [ vms ]).
	presenter refresh.
	self
		serverPublishesArchiveOf: outdatedVm
		lastModified: (DateAndTime year: 2999 month: 1 day: 15 hour: 12 minute: 0).
	self serverPublishesArchiveOf: upToDateVm lastModified: DateAndTime now - 1 day
]

{ #category : 'running' }
PhLVMPresenterUpdateTest >> tearDown [

	PhLTestVirtualMachineManager reset.
	vmStore ensureDeleteAll.
	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testOpeningRunsNoVmAndAsksNothingToTheServer [
	"The VM manager only reads what checks and installations stored"

	| window |
	window := presenter open.

	[
	self deny: (vmStore / outdatedVm id / PhLVmMetadata fileName) exists.
	self assert: PhLDownloadManager default stampRequestCount equals: 0 ] ensure: [ window close ]
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testDownloadUrlAndLocationOfSelectedVmAreShown [

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel downloadUrl label equals: outdatedVm downloadUrl.
	self assert: presenter detailPanel location label equals: (vmStore / '100-x64') fullName
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testNoDownloadUrlNorLocationIsShownWithoutSelectedVm [

	self assert: presenter detailPanel header label equals: ''.
	self assert: presenter detailPanel downloadUrl label equals: ''.
	self assert: presenter detailPanel location label equals: ''.
	self assert: presenter detailPanel installedOn label equals: ''.
	self assert: presenter detailPanel status label equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testNoDownloadUrlNorLocationIsShownWithSeveralSelectedVms [

	presenter selectVm: outdatedVm.

	presenter selectAllVms.

	self assert: presenter detailPanel downloadUrl label equals: ''.
	self assert: presenter detailPanel location label equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testHeaderOfSelectedVmShowsItsIdAndVersion [

	Smalltalk os isWindows ifTrue: [ ^ self skip ].
	presenter makeExecutableOf: outdatedVm print: 'Pharo v10.3.12 built on Oct 23 2026'.
	outdatedVm refreshVersion.

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel header label equals: 'VM 100-x64 (10.3.12)'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testHeaderOfSelectedVmShowsOnlyItsIdWhenVersionIsUnknown [

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel header label equals: 'VM 100-x64'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testVersionIsEmptyUntilStored [
	"The VM manager does not run the VM to get its version"

	Smalltalk os isWindows ifTrue: [ ^ self skip ].
	presenter makeExecutableOf: outdatedVm print: 'Pharo v10.3.12 built on Oct 23 2026'.

	self assert: (presenter versionDescriptionFor: outdatedVm) equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testVersionOfVmIsShown [

	Smalltalk os isWindows ifTrue: [ ^ self skip ].
	presenter makeExecutableOf: outdatedVm print: 'Pharo v10.3.12 built on Oct 23 2026'.

	outdatedVm refreshVersion.

	self assert: (presenter versionDescriptionFor: outdatedVm) equals: '10.3.12'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testToolbarDoesNotShowVmInFolder [
	"The location link of the detail panel shows the VM in its folder"

	| commandNames |
	commandNames := PhLVMPresenter buildToolbarGroup entries collect: [ :each | each name ].

	self assert: commandNames asArray equals: #( 'Update' 'Delete' )
]

{ #category : 'helpers' }
PhLVMPresenterUpdateTest >> installedVmNamed: aName [

	| vm |
	presenter createVmNamed: aName.
	vm := presenter vmFor: aName.
	vms add: vm.
	^ vm
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testDetailOfSelectedVmShowsInstallationDateAndStatus [

	self checkForUpdates.

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel installedOn label equals: Date today yyyymmdd.
	self
		assert: presenter detailPanel status label
		equals: 'Update available, published on 2999-01-15'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testSelectedVmIsRefreshedWhenCheckIsDone [

	| window |
	window := presenter open.
	[
	presenter selectVm: outdatedVm.
	self checkForUpdates.

	PhLVmUpdateAnnouncer default announce: PhLVmUpdateCheckDone new.
	World doOneCycle.

	self
		assert: presenter detailPanel status label
		equals: 'Update available, published on 2999-01-15' ] ensure: [ window close ].
	self deny: (PhLVmUpdateAnnouncer default hasSubscriber: presenter)
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testDetailOfUpToDateVmShowsItsStatus [

	self checkForUpdates.

	presenter selectVm: upToDateVm.

	self assert: presenter detailPanel status label equals: 'Up to date'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusIsNotCheckedBeforeAnyCheck [

	self assert: (presenter statusFor: outdatedVm) equals: 'Not checked'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusOfCustomVm [

	| customVm |
	customVm := self installedVmNamed: '130-x64-stable-gtk'.

	self assert: (presenter statusFor: customVm) equals: 'Custom VM'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusOfVmNotInstalled [

	| missingVm |
	missingVm := PhLVirtualMachine new
		             id: '110-x64';
		             manager: PhLTestVirtualMachineManager new;
		             yourself.
	vms add: missingVm.

	self assert: (presenter statusFor: missingVm) equals: 'Not installed'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusIsTheResultOfTheLastCheckWithoutAskingTheServer [

	| requestCount |
	self checkForUpdates.
	requestCount := PhLDownloadManager default stampRequestCount.

	self assert: (presenter statusFor: outdatedVm) equals: 'Update available'.
	self assert: (presenter statusFor: upToDateVm) equals: 'Up to date'.
	self assert: PhLDownloadManager default stampRequestCount equals: requestCount
]

{ #category : 'helpers' }
PhLVMPresenterUpdateTest >> checkForUpdates [

	vms do: [ :each | each checkForUpdate ]
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testSelectingVms [

	presenter selectVms: { outdatedVm }.

	self assert: (presenter selectedVms collect: [ :each | each id ]) asArray equals: #( '100-x64' ).
	self assert: presenter detailPanel header label equals: 'VM 100-x64'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testIconOfUpToDateVm [

	| icon |
	self checkForUpdates.

	icon := presenter iconFor: upToDateVm.

	self assert: icon form identicalTo: (presenter iconNamed: #testGreen).
	self assert: icon balloonText equals: 'VM available'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testIconOfVmWithUpdateAvailable [

	| icon |
	self checkForUpdates.

	icon := presenter iconFor: outdatedVm.

	self assert: icon form identicalTo: (presenter iconNamed: #testYellow).
	"Balloon texts are wrapped"
	self assert: (' ' join: icon balloonText asString lines) equals: 'Update available, published on 2999-01-15'
]
