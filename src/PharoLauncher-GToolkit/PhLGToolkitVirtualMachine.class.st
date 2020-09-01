Class {
	#name : #PhLGToolkitVirtualMachine,
	#superclass : #PhLVirtualMachine,
	#category : #'PharoLauncher-GToolkit'
}

{ #category : #querying }
PhLGToolkitVirtualMachine class >> executableName [
	^ 'GlamorousToolkit'
]

{ #category : #testing }
PhLGToolkitVirtualMachine class >> isClassForDirectory: aFileReference private: isPrivateVm [
	^ aFileReference basename beginsWith: 'gt-'
]
