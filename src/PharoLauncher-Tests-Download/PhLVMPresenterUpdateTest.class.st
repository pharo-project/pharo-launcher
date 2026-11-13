"
I specify how the VM manager shows the virtual machines having an update available.
"
Class {
	#name : 'PhLVMPresenterUpdateTest',
	#superclass : 'TestCase',
	#instVars : [
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
	self serverPublishesArchiveOf: outdatedVm lastModified: DateAndTime now + 1 day.
	self serverPublishesArchiveOf: upToDateVm lastModified: DateAndTime now - 1 day
]

{ #category : 'running' }
PhLVMPresenterUpdateTest >> tearDown [

	PhLTestVirtualMachineManager reset.
	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testNoVmIsMarkedBeforeCheckingForUpdates [

	self assert: (presenter updateDescriptionFor: outdatedVm) equals: ''
]

{ #category : 'tests' }
PhLVMPresenterUpdateTest >> testVmWithUpdateAvailableIsMarkedOnceCheckedForUpdates [

	presenter checkForUpdates.

	self assert: (presenter updateDescriptionFor: outdatedVm) equals: 'Update available'.
	self assert: (presenter updateDescriptionFor: upToDateVm) equals: ''
]
