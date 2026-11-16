Class {
	#name : 'PhLUpdateVmCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'asserting' }
PhLUpdateVmCommandTest >> isUpdated: aVm [

	^ (aVm vmStore / aVm name / 'fetched!') exists
]

{ #category : 'running' }
PhLUpdateVmCommandTest >> setUp [
	super setUp.
	presenter := PhLTestVmPresenter new
]

{ #category : 'running' }
PhLUpdateVmCommandTest >> tearDown [
	PhLTestVirtualMachineManager reset.
	super tearDown
]

{ #category : 'tests' }
PhLUpdateVmCommandTest >> testCanUpdateManyVms [
	| command fooVmName vms vmFolderEntries |
	command := PhLUpdateVmCommand new.
	command context: presenter.
	fooVmName := '90-Foo'.
	presenter createVmNamed: fooVmName.
	vms := {fooVmName . presenter singleVmName}
		collect: [:each | presenter vmFor: each ].
	presenter selection: vms.
	
	command execute.
	
	vms := presenter vmNames.
	self
		assertCollection: vms
		hasSameElements: {fooVmName . presenter singleVmName}.
	presenter selectedVms do: [ :vm |
		vmFolderEntries := (vm vmStore / vm name) entries.
		self 
			assertCollection: (vmFolderEntries collect: #name)
			hasSameElements: #('pharo' 'Pharo.app' 'fetched!'). ]

]

{ #category : 'tests' }
PhLUpdateVmCommandTest >> testCanUpdateOneVm [
	| command vms vmFolderEntries |
	command := PhLUpdateVmCommand new.
	command context: presenter.
	
	command execute.
	
	vms := presenter vmNames.
	self
		assertCollection: vms
		hasSameElements: { presenter singleVmName }.
	vmFolderEntries := (presenter selectedVms first vmStore / presenter singleVmName) entries.
	self 
		assertCollection: (vmFolderEntries collect: #name)
		hasSameElements: #('pharo' 'Pharo.app' 'fetched!').
]

{ #category : 'tests' }
PhLUpdateVmCommandTest >> testVmFailingToUpdateIsSkippedAndReported [

	| command failingVm otherVm |
	presenter createVmNamed: '90-Foo'.
	failingVm := presenter vmFor: '90-Foo'.
	failingVm manager: PhLFailingVirtualMachineManager new.
	otherVm := presenter vmFor: presenter singleVmName.
	presenter selection: {
			failingVm.
			otherVm }.
	command := PhLUpdateVmCommand new.
	command context: presenter.

	command execute.

	self deny: (self isUpdated: failingVm).
	self assert: (self isUpdated: otherVm).
	self assert: (presenter information message includesSubstring: '90-Foo')
]
