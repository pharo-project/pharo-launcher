"
Only usefull for the tests, is usefull to create ""fake"" virtual machines. 
"
Class {
	#name : #PhLVirtualMachinesMock,
	#superclass : #Object,
	#instVars : [
		'id',
		'isUpdated',
		'isDeleted',
		'isValid',
		'lastUpdateTime',
		'downloadUrl'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #accessing }
PhLVirtualMachinesMock class >> atRandom [
	|randomTimeBlock attrArray|
	
	randomTimeBlock := [ (DateAndTime fromUnixTime: (1 to: 1600000000) atRandom ) asString ]. 
	attrArray := 
			{{'90	-x86'. true. randomTimeBlock value. 'https://files.pharo.org/get-files/90/pharo-vm-Darwin-x86_64-stable.zip'}.
			{'90-x64'. true. randomTimeBlock value. 'https://files.pharo.org/get-files/90/pharo-vm-Darwin-x86_64-stable.zip'}.
			{'80-x86'. true. randomTimeBlock value. 'https://files.pharo.org/get-files/80/pharo-mac-stable.zip'}.
			{'80-x64'. true. randomTimeBlock value. 'https://files.pharo.org/get-files/80/pharo64-mac-stable.zip'}.
			{'80-x64-headless'. true. randomTimeBlock value. 'https://files.pharo.org/get-files/80/pharo-mac-stable.zip'}.
			{'100-x64'. false. randomTimeBlock value. 'https://files.pharo.org/get-files/100/pharo-vm-Darwin-x86_64-stable.zip'}.		
			 } atRandom.
	^ self new 
		id: attrArray first;
		isValid: attrArray second;
		lastUpdateTime: attrArray third;
		downloadUrl: attrArray fourth;
		yourself 

]

{ #category : #accessing }
PhLVirtualMachinesMock class >> id: aString [
	^ self atRandom id: aString
]

{ #category : #accessing }
PhLVirtualMachinesMock >> downloadUrl [

	^ downloadUrl 
]

{ #category : #accessing }
PhLVirtualMachinesMock >> downloadUrl: anUrl [

	downloadUrl := anUrl
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

{ #category : #accessing }
PhLVirtualMachinesMock >> isValid [ 

	^ isValid 
]

{ #category : #accessing }
PhLVirtualMachinesMock >> isValid: aBool [

	isValid := aBool
	
]

{ #category : #accessing }
PhLVirtualMachinesMock >> lastUpdateTime [

	^ lastUpdateTime 
]

{ #category : #accessing }
PhLVirtualMachinesMock >> lastUpdateTime: aDateTime [

	lastUpdateTime := aDateTime 
]

{ #category : #accessing }
PhLVirtualMachinesMock >> lastUpdateTimeDescription [

	^ lastUpdateTime asString
]

{ #category : #instance }
PhLVirtualMachinesMock >> removeFromSystem [
	self isDeleted: true.
   
]

{ #category : #instance }
PhLVirtualMachinesMock >> updateFromUrl [
	 self isUpdated: true.
]
