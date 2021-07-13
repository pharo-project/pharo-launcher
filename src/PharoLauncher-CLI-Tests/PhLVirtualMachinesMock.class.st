"
Only usefull for the tests, is usefull to create ""fake"" virtual machines. 
"
Class {
	#name : #PhLVirtualMachinesMock,
	#superclass : #Object,
	#instVars : [
		'id',
		'isUpdated',
		'isDeleted'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #accessing }
PhLVirtualMachinesMock class >> id: aString [
	^ self new id: aString
]

{ #category : #instance }
PhLVirtualMachinesMock >> cliPrintOn: aStream [
	aStream nextPutAll: self id
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

{ #category : #instance }
PhLVirtualMachinesMock >> initialize [ 
	super initialize.
	self isDeleted: false.
	self isUpdated: false
]

{ #category : #accessing }
PhLVirtualMachinesMock >> isDeleted [
	^ isDeleted
]

{ #category : #accessing }
PhLVirtualMachinesMock >> isDeleted: aBoolean [
	isDeleted := aBoolean
]

{ #category : #accessing }
PhLVirtualMachinesMock >> isUpdated [
	^ isUpdated
]

{ #category : #accessing }
PhLVirtualMachinesMock >> isUpdated: aboolean [
	isUpdated := aboolean
]

{ #category : #printing }
PhLVirtualMachinesMock >> lastUpdateTime [
	^ 'some random update time'
]

{ #category : #instance }
PhLVirtualMachinesMock >> removeFromSystem [
	self isDeleted: true.
   
]

{ #category : #instance }
PhLVirtualMachinesMock >> updateFromUrl [
	 self isUpdated: true.
]
