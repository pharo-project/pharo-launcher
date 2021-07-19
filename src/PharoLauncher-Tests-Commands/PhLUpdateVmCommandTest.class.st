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
PhLUpdateVmCommandTest >> testCanUpdateManyPrivateVms [
	| command vms vmFolderEntries |
	command := PhLUpdateVmCommand new.
	command context: presenter.
	presenter 
		showPrivateVms;
		createVmNamed: '6504' private: true;
		createVmNamed: '68021' private: true;
		selection: { 
			presenter vmFor: '6504' private: true .
			presenter vmFor: '68021' private: true }.
	
	command execute.
	
	vms := presenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #('68021' '6504').
	vmFolderEntries := (presenter selectedVms first vmStore / '68021') entries.
	self 
		assertCollection: (vmFolderEntries collect: #name)
		hasSameElements: #('pharo' 'Pharo.app' 'fetched!').
]

{ #category : #tests }
PhLUpdateVmCommandTest >> testCanUpdateManyVms [
	| command fooVmName vms vmFolderEntries |
	command := PhLUpdateVmCommand new.
	command context: presenter.
	fooVmName := '90-Foo'.
	presenter createVmNamed: fooVmName.
	vms := {fooVmName . presenter singleVmName}
		collect: [:each | presenter vmFor: each private: false ].
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
