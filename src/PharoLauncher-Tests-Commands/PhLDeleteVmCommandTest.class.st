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
	super setUp.
	presenter := PhLTestVmPresenter new
]

{ #category : #running }
PhLDeleteVmCommandTest >> tearDown [
	PhLTestVirtualMachineManager reset.	"reset vm store to use for tests"
	super tearDown
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
PhLDeleteVmCommandTest >> testCanDeleteManyVms [
	| command vms |		
	command := PhLDeleteVmCommand new.
	command context: presenter.
	presenter createVmNamed: 'Foo'.
	vms := {presenter singleVmName . 'Foo'}
		collect: [:each | presenter vmFor: each ].
	presenter selection: vms.
	
	command execute.
	
	vms := command vmsPresenter vmNames.
	self
		assertCollection: vms
		hasSameElements: #().
]
