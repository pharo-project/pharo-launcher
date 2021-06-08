"
Only usefull for the tests, is usefull to create ""fake"" virtual machines. 
"
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

{ #category : #printing }
PhLVirtualMachinesMock >> downloadUrl [
	'some url'
]

{ #category : #accessing }
PhLVirtualMachinesMock >> id [ 
   ^id
]

{ #category : #accessing }
PhLVirtualMachinesMock >> id: aString [
	id := aString
]

{ #category : #printing }
PhLVirtualMachinesMock >> lastUpdateTime [
	^ 'some random update time'
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
