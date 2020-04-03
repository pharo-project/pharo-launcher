"
Superclass of all commands that are applied to one VM or multiple VMs.
"
Class {
	#name : #PhLVmCommand,
	#superclass : #CmCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #initialization }
PhLVmCommand >> initialize [
	super initialize.
	self description: self class comment
]

{ #category : #accessing }
PhLVmCommand >> vmsPresenter [
	^ self context
]
