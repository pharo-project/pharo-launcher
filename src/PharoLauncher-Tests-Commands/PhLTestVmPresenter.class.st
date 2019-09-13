"
A presenter for Pharo Launcher VMs used for test purposes
"
Class {
	#name : #PhLTestVmPresenter,
	#superclass : #PhLVMPresenter,
	#instVars : [
		'fileSystem',
		'request',
		'vmStore',
		'selection'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #adding }
PhLTestVmPresenter >> createVmNamed: aName [
	self createVmNamed: aName private: false
]

{ #category : #adding }
PhLTestVmPresenter >> createVmNamed: aName private: isPrivateVm [
	| vmDirectory appDir root |
	root := isPrivateVm 
		ifTrue: [ fileSystem root / 'private' ] 
		ifFalse: [ fileSystem root ].
	vmDirectory := root / aName.
	vmDirectory ensureCreateDirectory.
	appDir := (vmDirectory / 'Pharo.app') ensureCreateDirectory.
	(appDir / PhLVirtualMachine executableName) ensureCreateFile.
]

{ #category : #initialization }
PhLTestVmPresenter >> initialize [
	| datasource |
	fileSystem := FileSystem memory.
	(fileSystem root / 'private') ensureCreateDirectory.
	datasource := PhLVirtualMachinesDataSource
		vmsBlock:
			[ fileSystem root directoryNames reject: [ :name | name = 'private' ] ]
		privateVmsBlock: [ (fileSystem root / 'private') directoryNames ].
	self model: datasource.
	vmStore := fileSystem root.
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
	^ 'TestVM'
]

{ #category : #private }
PhLTestVmPresenter >> vmFor: aName private: isPrivateVm [
	| root vm |
	root := isPrivateVm 
		ifTrue: [ fileSystem root / 'private' ] 
		ifFalse: [ fileSystem root ].
	vm := PhLVirtualMachine
		directory: root / aName
		private: isPrivateVm.
	vm vmStore: root.
	^ vm
]

{ #category : #querying }
PhLTestVmPresenter >> vmNames [
	^ shouldShowPrivateVms 
		ifTrue:[ self datasource privateVirtualMachines ]
		ifFalse: [ self datasource virtualMachines ]
]
