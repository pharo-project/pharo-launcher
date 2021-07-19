Class {
	#name : #PhLVmProviderTest,
	#superclass : #TestCase,
	#instVars : [
		'vmProvider'
	],
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #running }
PhLVmProviderTest >> setUp [
	vmProvider := PhLVmProvider new.
]

{ #category : #tests }
PhLVmProviderTest >> testCanDetectArchitecture [
	self assert: (vmProvider hostArchitecture includesSubstring: '64')
]

{ #category : #tests }
PhLVmProviderTest >> testCanDetectOS [
	self assert: (vmProvider class supportedOs includes: vmProvider hostOS)
]

{ #category : #tests }
PhLVmProviderTest >> testLatestUrlIsValidAndAvailable [
	| url |
	url := vmProvider urlForPharo: 90 stable: false.
	
	self assert: (url asString includesSubstring: 'latest').
	self assert: (ZnEasy head: url) isSuccess
]

{ #category : #tests }
PhLVmProviderTest >> testStableUrlIsValidAndAvailable [
	| url |
	url := vmProvider urlForPharo: 90 stable: true.
	
	self assert: (url asString includesSubstring: 'stable').
	self assert: (ZnEasy head: url) isSuccess
]
