"
A presenter for Pharo Launcher VMs used for test purposes
"
Class {
	#name : 'PhLTestVmPresenter',
	#superclass : 'PhLVMPresenter',
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#instVars : [
		'selection',
		'vmManager',
		'vmStoreRoot',
		'information'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'adding' }
PhLTestVmPresenter >> createVmNamed: aName [
	| vmDirectory appDir |
	vmDirectory := vmStoreRoot / aName.
	vmDirectory ensureCreateDirectory.
	"needed on OS X"
	appDir := (vmDirectory / 'Pharo.app') ensureCreateDirectory.
	(appDir / 'Pharo') ensureCreateFile.
	"needed on Linux"
	(vmDirectory / 'pharo') binaryWriteStreamDo: [ :stream | stream nextPutAll: PhLVirtualMachine elfMagicNumber ].
	 
]

{ #category : 'testing' }
PhLTestVmPresenter >> hasAlternateRowsColor [

	^ (vmTable adapter widget container instVarNamed: #rowColors) isNotNil
]

{ #category : 'accessing' }
PhLTestVmPresenter >> information [
	^ information
]

{ #category : 'initialization' }
PhLTestVmPresenter >> initialize [
	| datasource |
	vmManager := PhLTestVirtualMachineManager new.
	vmStoreRoot := vmManager vmStore.
	(vmStoreRoot / 'private') ensureCreateDirectory.
	datasource := PhLVirtualMachinesDataSource
		vmsBlock:
			[ vmStoreRoot directoryNames reject: [ :name | name = 'private' ] ].
	self model: datasource.
	self createVmNamed: self singleVmName.
	super initialize
]

{ #category : 'user interaction' }
PhLTestVmPresenter >> newConfirmation [
	^ PhLTestConfirmation new
]

{ #category : 'user interaction' }
PhLTestVmPresenter >> newInformation [
	^ information := PhLTestConfirmation new
]

{ #category : 'accessing' }
PhLTestVmPresenter >> selectedVms [
	"The selection set by a test, else the one of the table, else the single VM"

	^ selection ifNil: [ super selectedVms ifEmpty: [ { self vmFor: self singleVmName } ] ]
]

{ #category : 'configuring' }
PhLTestVmPresenter >> selection: aListOfVms [
	selection := aListOfVms
]

{ #category : 'initialization' }
PhLTestVmPresenter >> singleVmName [
	^ '80-TestVM'
]

{ #category : 'private' }
PhLTestVmPresenter >> vmFor: aName [

	| vm |
	vm := PhLVirtualMachine directory: vmStoreRoot / aName.
	vm manager: PhLTestVirtualMachineManager new.
	^ vm
]

{ #category : 'querying' }
PhLTestVmPresenter >> vmNames [
	^ self datasource virtualMachines
]

{ #category : 'private' }
PhLTestVmPresenter >> vmStoreRoot [

	^ vmStoreRoot
]
