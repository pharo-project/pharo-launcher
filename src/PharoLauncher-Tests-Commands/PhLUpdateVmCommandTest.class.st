Class {
	#name : #PhLUpdateVmCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLUpdateVmCommandTest >> setUp [
	super setUp.
	presenter := PhLTestVmPresenter new
]

{ #category : #running }
PhLUpdateVmCommandTest >> tearDown [
	PhLTestVirtualMachineManager reset.
	super tearDown
]

{ #category : #tests }
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

{ #category : #tests }
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
