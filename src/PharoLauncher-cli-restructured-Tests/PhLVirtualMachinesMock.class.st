Class {
	#name : #PhLVirtualMachinesMock,
	#superclass : #Object,
	#instVars : [
		'id',
		'state'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #accessing }
PhLVirtualMachinesMock class >> id: aString [
	^ self new id: aString
]

{ #category : #accessing }
PhLVirtualMachinesMock >> id [ 
   ^id
]

{ #category : #accessing }
PhLVirtualMachinesMock >> id: aString [
	id := aString
]

{ #category : #instance }
PhLVirtualMachinesMock >> removeFromSystem [
	state :='successfully deleted'.
   
]

{ #category : #accessing }
PhLVirtualMachinesMock >> state [ 
   ^state
]

{ #category : #instance }
PhLVirtualMachinesMock >> updateFromUrl [
	 state:='updated'.
]
