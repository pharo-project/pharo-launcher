"
I specify what the update checker stores and which virtual machines it answers as to update.
"
Class {
	#name : 'PhLVmUpdateCheckerTest',
	#superclass : 'PhLVirtualMachineStoreTest',
	#instVars : [
		'checker',
		'shouldRun'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLVmUpdateCheckerTest >> idsOfVmsToUpdate [

	^ (checker vmsToUpdate collect: [ :each | each id ]) asArray
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

	super setUp.
	shouldRun := PhLVmUpdateChecker shouldRun.
	PhLVmUpdateChecker shouldRun: true.
	checker := PhLVmUpdateChecker new
]

{ #category : 'running' }
PhLVmUpdateCheckerTest >> tearDown [

	checker announcer unsubscribe: self.
	PhLVmUpdateChecker shouldRun: shouldRun.
	super tearDown
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testNoVmToUpdateWhenDisabled [

	self installVmWithUpdateAvailable: '70-x64'.
	PhLVmUpdateChecker shouldRun: false.

	checker check.

	self assertEmpty: checker vmsToUpdate
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testNoVmToUpdateWhenNoUpdateIsAvailable [

	self createVmNamed: '70-x64'.
	self
		serverPublishesArchiveOf: (PhLVirtualMachine id: '70-x64')
		lastModified: DateAndTime now - 1 day.

	checker check.

	self assertEmpty: checker vmsToUpdate
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testNoVmToUpdateWhenServerDoesNotAnswer [

	self createVmNamed: '70-x64'.

	checker check.

	self assertEmpty: checker vmsToUpdate
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testVmIsToUpdateWhenUpdateIsAvailable [

	self installVmWithUpdateAvailable: '70-x64'.

	checker check.

	self assert: self idsOfVmsToUpdate equals: #( '70-x64' )
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testVmsToUpdateAreReadFromTheLastCheck [

	| requestCount |
	self installVmWithUpdateAvailable: '70-x64'.
	checker check.
	requestCount := self server stampRequestCount.

	self assert: self idsOfVmsToUpdate equals: #( '70-x64' ).
	self assert: self server stampRequestCount equals: requestCount
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testEveryOutdatedVmIsToUpdate [

	self installVmWithUpdateAvailable: '70-x64'.
	self installVmWithUpdateAvailable: '130-x64'.

	checker check.

	self assertCollection: self idsOfVmsToUpdate hasSameElements: #( '70-x64' '130-x64' )
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
PhLVmUpdateCheckerTest >> testRecordsResultOfEveryInstalledVm [

	self installVmWithUpdateAvailable: '130-x64'.

	checker check.

	self assert: (PhLVirtualMachine id: '130-x64') status equals: 'Update available'
]

{ #category : 'helpers' }
PhLVmUpdateCheckerTest >> installVmNamed: aVmId printing: aString [

	| vm |
	Smalltalk os isWindows ifTrue: [ ^ self skip ].
	self createVmNamed: aVmId.
	vm := PhLVirtualMachine id: aVmId.
	self makeExecutableOf: vm print: aString.
	^ vm
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testAnnouncesWhenCheckIsDoneEvenWhenDisabled [
	"Versions are stored even when the server is not asked"

	| isDone |
	PhLVmUpdateChecker shouldRun: false.
	isDone := false.
	checker announcer when: PhLVmUpdateCheckDone do: [ isDone := true ] for: self.

	checker check.

	self assert: isDone
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testStoresVersionOfCustomVm [

	| vm |
	vm := self installVmNamed: '130-x64-stable-gtk' printing: 'Pharo v10.3.9 built on Nov 17 2025'.

	checker check.

	self assert: vm storedVersion equals: '10.3.9'
]

{ #category : 'tests' }
PhLVmUpdateCheckerTest >> testStoresVersionsWithoutAskingTheServerWhenDisabled [

	| vm |
	vm := self installVmNamed: '70-x64' printing: 'Pharo v10.3.12 built on Oct 23 2026'.
	self serverPublishesArchiveOf: vm lastModified: DateAndTime now + 1 day.
	PhLVmUpdateChecker shouldRun: false.

	checker check.

	self assert: vm storedVersion equals: '10.3.12'.
	self assert: vm status equals: 'Not checked'.
	self assert: self server stampRequestCount equals: 0
]
