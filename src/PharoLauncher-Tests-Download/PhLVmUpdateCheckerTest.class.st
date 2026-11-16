"
I specify which virtual machines the update checker announces.
"
Class {
	#name : 'PhLVmUpdateCheckerTest',
	#superclass : 'PhLVirtualMachineStoreTest',
	#instVars : [
		'checker',
		'announcedVms',
		'shouldRun'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLVmUpdateCheckerTest >> announcedVmIds [

	^ (announcedVms collect: [ :each | each id ]) asArray
]

{ #category : 'helpers' }
PhLVmUpdateCheckerTest >> installVmWithUpdateAvailable: aVmId [

	self createVmNamed: aVmId.
	self
		serverPublishesArchiveOf: (PhLVirtualMachine id: aVmId)
		lastModified: DateAndTime now + 1 day
]

{ #category : 'running' }
PhLVmUpdateCheckerTest >> setUp [
	"The image of the test image repository runs on the 70-x64 VM"

	super setUp.
	shouldRun := PhLVmUpdateChecker shouldRun.
	PhLVmUpdateChecker shouldRun: true.
	announcedVms := #(  ).
	checker := PhLVmUpdateChecker imageRepository: PhLTestImageRepository new.
	checker announcer
		when: PhLVmUpdatesAvailable
		do: [ :announcement | announcedVms := announcement vms ]
		for: self
]

{ #category : 'running' }
PhLVmUpdateCheckerTest >> tearDown [

	checker announcer unsubscribe: self.
	PhLVmUpdateChecker shouldRun: shouldRun.
	super tearDown
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testAnnouncesNothingWhenDisabled [

	self installVmWithUpdateAvailable: '70-x64'.
	PhLVmUpdateChecker shouldRun: false.

	checker check.

	self assertEmpty: announcedVms
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testAnnouncesNothingWhenNoUpdateIsAvailable [

	self createVmNamed: '70-x64'.
	self
		serverPublishesArchiveOf: (PhLVirtualMachine id: '70-x64')
		lastModified: DateAndTime now - 1 day.

	checker check.

	self assertEmpty: announcedVms
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testAnnouncesNothingWhenServerDoesNotAnswer [

	self createVmNamed: '70-x64'.

	checker check.

	self assertEmpty: announcedVms
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testAnnouncesVmUsedByAnImageWhenUpdateIsAvailable [

	self installVmWithUpdateAvailable: '70-x64'.

	checker check.

	self assert: self announcedVmIds equals: #( '70-x64' )
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testDoesNotAnnounceVmUsedByNoImage [

	self installVmWithUpdateAvailable: '70-x64'.
	self installVmWithUpdateAvailable: '130-x64'.

	checker check.

	self assert: self announcedVmIds equals: #( '70-x64' )
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testAnnouncesWhenCheckIsDone [

	| isDone |
	isDone := false.
	checker announcer when: PhLVmUpdateCheckDone do: [ isDone := true ] for: self.

	checker check.

	self assert: isDone
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testRecordsNothingWhenDisabled [

	self installVmWithUpdateAvailable: '70-x64'.
	PhLVmUpdateChecker shouldRun: false.

	checker check.

	self assert: (PhLVirtualMachine id: '70-x64') status equals: 'Not checked'
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testRecordsResultOfVmUsedByNoImage [
	"The VM manager shows the status of every installed VM"

	self installVmWithUpdateAvailable: '130-x64'.

	checker check.

	self assert: (PhLVirtualMachine id: '130-x64') status equals: 'Update available'
]
