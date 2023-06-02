"
A presenter for Pharo Launcher VMs used for test purposes
"
Class {
	#name : #PhLTestVmPresenter,
	#superclass : #PhLVMPresenter,
	#traits : 'TPhLVirtualMachineTestUtil',
	#classTraits : 'TPhLVirtualMachineTestUtil classTrait',
	#instVars : [
		'selection',
		'vmManager',
		'vmStoreRoot'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #initialization }
PhLTestVmPresenter >> initialize [
	| datasource |
	vmManager := PhLTestVirtualMachineManager new.
	vmStoreRoot := vmManager vmStore.
	(vmStoreRoot / 'private') ensureCreateDirectory.
	datasource := PhLVirtualMachinesDataSource
		vmsBlock:
			[ vmStoreRoot directoryNames reject: [ :name | name = 'private' ] ]
		privateVmsBlock: [ (vmStoreRoot / 'private') directoryNames ].
	self model: datasource.
	self createVmNamed: self singleVmName.
	super initialize
]

{ #category : #'user interaction' }
PhLTestVmPresenter >> newConfirmation [
	^ PhLTestConfirmation new
]

{ #category : #accessing }
PhLTestVmPresenter >> selectedVms [
	^ selection 
		ifNotNil: [ selection ]
		ifNil: [ { self vmFor: self singleVmName private: false } ]
]

{ #category : #configuring }
PhLTestVmPresenter >> selection: aListOfVms [
	selection := aListOfVms
]

{ #category : #initialization }
PhLTestVmPresenter >> singleVmName [
	^ '80-TestVM'
]

{ #category : #private }
PhLTestVmPresenter >> vmFor: aName private: isPrivateVm [
	| root vm |
	root := isPrivateVm 
		ifTrue: [ vmStoreRoot / 'private' ] 
		ifFalse: [ vmStoreRoot ].
	vm := PhLVirtualMachine
		directory: root / aName
		private: isPrivateVm.
	vm manager: PhLTestVirtualMachineManager new.
	^ vm
]

{ #category : #querying }
PhLTestVmPresenter >> vmNames [
	^ shouldShowPrivateVms 
		ifTrue:[ self datasource privateVirtualMachines ]
		ifFalse: [ self datasource virtualMachines ]
]

{ #category : #private }
PhLTestVmPresenter >> vmStoreRoot [

	^ vmStoreRoot
]
