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
		'upToDateVm'
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
	presenter model: (PhLVirtualMachinesDataSource vmsBlock: [
			 {
				 outdatedVm.
				 upToDateVm } ]).
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
PhLVMPresenterUpdateTest >> testDownloadUrlAndLocationOfSelectedVmAreShown [

	presenter selectVm: outdatedVm.

	self assert: presenter detailPanel downloadUrl label equals: outdatedVm downloadUrl.
	self assert: presenter detailPanel location label equals: (vmStore / '100-x64') fullName
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testNoDownloadUrlNorLocationIsShownWithoutSelectedVm [

	self assert: presenter detailPanel downloadUrl label equals: ''.
	self assert: presenter detailPanel location label equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testNoDownloadUrlNorLocationIsShownWithSeveralSelectedVms [

	presenter selectVm: outdatedVm.

	presenter selectAllVms.

	self assert: presenter detailPanel downloadUrl label equals: ''.
	self assert: presenter detailPanel location label equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testNoDetailIsShownBeforeFetchingThem [

	self assert: (presenter updateDescriptionFor: outdatedVm) equals: ''.
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
PhLVMPresenterUpdateTest >> testVmWithUpdateAvailableShowsPublicationDateOfTheUpdate [

	presenter fetchDetails.

	self assert: (presenter updateDescriptionFor: outdatedVm) equals: '2999-01-15'.
	self assert: (presenter updateDescriptionFor: upToDateVm) equals: ''
]
