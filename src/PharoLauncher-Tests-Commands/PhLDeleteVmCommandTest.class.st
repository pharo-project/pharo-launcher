Class {
	#name : #PhLDeleteVmCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLDeleteVmCommandTest >> setUp [
	presenter := PhLTestVmPresenter new.
]

{ #category : #running }
PhLDeleteVmCommandTest >> tearDown [
	PhLTestVirtualMachineManager reset "reset vm store to use for tests"
]

{ #category : #tests }
PhLDeleteVmCommandTest >> testCanDeleteAPrivateVM [
	| command vms |		
	command := PhLDeleteVmCommand new.
	command context: presenter.
	presenter 
		showPrivateVms;
		createVmNamed: 'Bar' private: true;
		selection: { presenter vmFor: 'Bar' private: true }.
	
	command execute.
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #().
]

{ #category : #tests }
PhLDeleteVmCommandTest >> testCanDeleteAVM [
	| command vms |
	command := PhLDeleteVmCommand new.
	command context: presenter.
	presenter createVmNamed: 'Foo'.
	
	command execute.
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #('Foo').
]

{ #category : #tests }
PhLDeleteVmCommandTest >> testCanDeleteManyPrivateVms [
	| command vms |		
	command := PhLDeleteVmCommand new.
	command context: presenter.
	presenter 
		showPrivateVms;
		createVmNamed: 'Foo' private: true;
		createVmNamed: 'Bar' private: true;
		createVmNamed: 'Zee' private: true;
		selection: { presenter vmFor: 'Foo' private: true .
						presenter vmFor: 'Bar' private: true }.
	
	command execute.
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #('Zee').
]

{ #category : #tests }
PhLDeleteVmCommandTest >> testCanDeleteManyVms [
	| command vms |		
	command := PhLDeleteVmCommand new.
	command context: presenter.
	presenter createVmNamed: 'Foo'.
	vms := #('Foo' 'TestVM')
		collect: [:each | presenter vmFor: each private: false ].
	presenter selection: vms.
	
	command execute.
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #().
]
