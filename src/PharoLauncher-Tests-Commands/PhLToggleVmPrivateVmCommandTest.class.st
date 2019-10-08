Class {
	#name : #PhLToggleVmPrivateVmCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLToggleVmPrivateVmCommandTest >> setUp [
	presenter := PhLTestVmPresenter new.
]

{ #category : #running }
PhLToggleVmPrivateVmCommandTest >> tearDown [ 
	PhLTestVirtualMachineManager reset
]

{ #category : #tests }
PhLToggleVmPrivateVmCommandTest >> testPrivateVmsShownWhenButtonToggledOnce [
	| command vms |
	command := PhLToggleVmPrivateVmCommand new.
	command context: presenter.
	presenter createVmNamed: 'PrivateTestVM' private: true.
	
	command execute.
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #('PrivateTestVM').
]

{ #category : #tests }
PhLToggleVmPrivateVmCommandTest >> testVmsShownAtStartup [
	| command vms |
	command := PhLToggleVmPrivateVmCommand new.
	command context: presenter.
	presenter createVmNamed: 'PrivateTestVM' private: true.
	
	"NOOP we are testing the initial state"
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #('TestVM').
]

{ #category : #tests }
PhLToggleVmPrivateVmCommandTest >> testVmsShownWhenButtonToggledTwice [
	| command vms |
	command := PhLToggleVmPrivateVmCommand new.
	command context: presenter.
	presenter createVmNamed: 'Foo'.
	presenter createVmNamed: 'PrivateTestVM' private: true.
	
	command
		execute;
		execute.
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #('TestVM' 'Foo').
]
