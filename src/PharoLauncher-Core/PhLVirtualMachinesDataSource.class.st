"
I provide the list of virtual machines and private virtual machines for PharoLauncher.

"
Class {
	#name : #PhLVirtualMachinesDataSource,
	#superclass : #Object,
	#instVars : [
		'vmsBlock'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLVirtualMachinesDataSource class >> default [

	^ self vmsBlock: [ PhLVirtualMachineManager new virtualMachines 
								asSortedCollection: [ :vm1 :vm2 | vm1 > vm2 ] ]
]

{ #category : #'instance creation' }
PhLVirtualMachinesDataSource class >> vmsBlock: aBlock [
	^ self new 
		vmsBlock: aBlock;
		yourself
]

{ #category : #querying }
PhLVirtualMachinesDataSource >> virtualMachines [ 
	^ vmsBlock value
]

{ #category : #accessing }
PhLVirtualMachinesDataSource >> vmsBlock: aBlock [
	vmsBlock := aBlock
]
