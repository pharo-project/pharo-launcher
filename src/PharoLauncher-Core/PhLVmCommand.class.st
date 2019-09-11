"
Superclass of all commands that are applied to one VM or multiple VMs.
"
Class {
	#name : #PhLVmCommand,
	#superclass : #CmCommand,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #initialization }
PhLVmCommand >> initialize [ 
	super initialize.
	self basicDescription: self class comment
]

{ #category : #accessing }
PhLVmCommand >> vmsPresenter [
	^ self context
]
