"
I provide the list of virtual machines and private virtual machines for PharoLauncher.

"
Class {
	#name : #PhLVirtualMachinesDataSource,
	#superclass : #Object,
	#instVars : [
		'vmsBlock',
		'privateVmsBlock'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLVirtualMachinesDataSource class >> default [ 
	| vmsBlock privateVmsBlock |
	vmsBlock := [ PhLVirtualMachineManager new virtualMachines 
		asSortedCollection: [ :vm1 :vm2 | vm1 id > vm2 id ] ].
	privateVmsBlock := [ PhLVirtualMachineManager new availableVirtualMachinesByImageFormat 
		asSortedCollection: [ :vm1 :vm2 | vm1 id > vm2 id ] ].
	^ self vmsBlock: vmsBlock privateVmsBlock: privateVmsBlock 
]

{ #category : #'instance creation' }
PhLVirtualMachinesDataSource class >> vmsBlock: aBlock [
	^ self new 
		vmsBlock: aBlock;
		yourself
]

{ #category : #'instance creation' }
PhLVirtualMachinesDataSource class >> vmsBlock: vmsBlock privateVmsBlock: privateVmsBlock [
	^ (self vmsBlock: vmsBlock)
		privateVmsBlock: privateVmsBlock;
		yourself
]

{ #category : #querying }
PhLVirtualMachinesDataSource >> privateVirtualMachines [ 
	^ privateVmsBlock 
		ifNil: [ #() ]
		ifNotNil: [ privateVmsBlock value ]
]

{ #category : #accessing }
PhLVirtualMachinesDataSource >> privateVmsBlock: aBlock [
	privateVmsBlock := aBlock
]

{ #category : #querying }
PhLVirtualMachinesDataSource >> virtualMachines [ 
	^ vmsBlock value
]

{ #category : #accessing }
PhLVirtualMachinesDataSource >> vmsBlock: aBlock [
	vmsBlock := aBlock
]
