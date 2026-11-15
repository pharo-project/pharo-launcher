"
I specify how the VM manager shows the version of virtual machines and the ones having an update available.

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
		'vms',
		'shouldCheckUpdates'
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
	shouldCheckUpdates := PhLVmUpdateChecker shouldRun.
	PhLVmUpdateChecker shouldRun: true.
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
	PhLVmUpdateChecker shouldRun: shouldCheckUpdates.
	super tearDown
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testDetailsAreFetchedWhenOpened [

	| window |
	window := presenter open.

	[ self assert: presenter hasFetchedDetailsInBackground ] ensure: [ window close ]
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
	presenter fetchDetails.

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel header label equals: 'VM 100-x64 (10.3.12)'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testHeaderOfSelectedVmShowsOnlyItsIdWhenVersionIsUnknown [

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel header label equals: 'VM 100-x64'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testNoDetailIsShownBeforeFetchingThem [

	self assert: (presenter versionDescriptionFor: outdatedVm) equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testVersionOfVmIsShown [

	Smalltalk os isWindows ifTrue: [ ^ self skip ].
	presenter makeExecutableOf: outdatedVm print: 'Pharo v10.3.12 built on Oct 23 2026'.

	presenter fetchDetails.

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

	presenter fetchDetails.

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel installedOn label equals: Date today yyyymmdd.
	self
		assert: presenter detailPanel status label
		equals: 'Update available, published on 2999-01-15'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testDetailOfSelectedVmIsUpdatedOnceDetailsAreFetched [

	presenter selectVm: outdatedVm.

	presenter fetchDetails.

	self
		assert: presenter detailPanel status label
		equals: 'Update available, published on 2999-01-15'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testDetailOfUpToDateVmShowsItsStatus [

	presenter fetchDetails.

	presenter selectVm: upToDateVm.

	self assert: presenter detailPanel status label equals: 'Up to date'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusIsCheckingUntilUpdatesAreFetched [

	self assert: (presenter statusFor: outdatedVm) equals: 'Checking...'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusIsEmptyWhenUpdatesAreNotChecked [

	PhLVmUpdateChecker shouldRun: false.

	presenter fetchDetails.

	self assert: (presenter statusFor: outdatedVm) equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusOfCustomVm [

	| customVm |
	customVm := self installedVmNamed: '130-x64-stable-gtk'.

	presenter fetchDetails.

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

	presenter fetchDetails.

	self assert: (presenter statusFor: missingVm) equals: 'Not installed'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusOfVmUnknownToServer [

	| vm |
	vm := self installedVmNamed: '80-x64'.

	presenter fetchDetails.

	self assert: (presenter statusFor: vm) equals: 'Unknown (offline)'
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testStatusTellsIfUpdateIsAvailable [

	presenter fetchDetails.

	self assert: (presenter statusFor: outdatedVm) equals: 'Update available'.
	self assert: (presenter statusFor: upToDateVm) equals: 'Up to date'
]
