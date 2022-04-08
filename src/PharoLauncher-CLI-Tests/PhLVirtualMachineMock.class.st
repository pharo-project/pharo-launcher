"
Only usefull for the tests, is usefull to create ""fake"" virtual machines. 
"
Class {
	#name : #PhLVirtualMachineMock,
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
PhLVirtualMachineMock class >> atRandom [
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
PhLVirtualMachineMock class >> id: aString [
	^ self atRandom id: aString
]

{ #category : #accessing }
PhLVirtualMachineMock >> downloadUrl [

	^ downloadUrl 
]

{ #category : #accessing }
PhLVirtualMachineMock >> downloadUrl: anUrl [

	downloadUrl := anUrl
]

{ #category : #accessing }
PhLVirtualMachineMock >> id [ 
   ^id
]

{ #category : #accessing }
PhLVirtualMachineMock >> id: aString [
	id := aString
]

{ #category : #instance }
PhLVirtualMachineMock >> initialize [ 
	super initialize.
	self isDeleted: false.
	self isUpdated: false
]

{ #category : #accessing }
PhLVirtualMachineMock >> isDeleted [
	^ isDeleted
]

{ #category : #accessing }
PhLVirtualMachineMock >> isDeleted: aBoolean [
	isDeleted := aBoolean
]

{ #category : #accessing }
PhLVirtualMachineMock >> isUpdated [
	^ isUpdated
]

{ #category : #accessing }
PhLVirtualMachineMock >> isUpdated: aboolean [
	isUpdated := aboolean
]

{ #category : #accessing }
PhLVirtualMachineMock >> isValid [ 

	^ isValid 
]

{ #category : #accessing }
PhLVirtualMachineMock >> isValid: aBool [

	isValid := aBool
	
]

{ #category : #accessing }
PhLVirtualMachineMock >> lastUpdateTime [

	^ lastUpdateTime 
]

{ #category : #accessing }
PhLVirtualMachineMock >> lastUpdateTime: aDateTime [

	lastUpdateTime := aDateTime 
]

{ #category : #accessing }
PhLVirtualMachineMock >> lastUpdateTimeDescription [

	^ lastUpdateTime asString
]

{ #category : #instance }
PhLVirtualMachineMock >> removeFromSystem [
	self isDeleted: true.
   
]

{ #category : #instance }
PhLVirtualMachineMock >> updateFromUrl [
	 self isUpdated: true.
]
