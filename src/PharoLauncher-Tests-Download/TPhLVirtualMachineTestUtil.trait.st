Trait {
	#name : #TPhLVirtualMachineTestUtil,
	#category : 'PharoLauncher-Tests-Download'
}

{ #category : #tests }
TPhLVirtualMachineTestUtil >> replaceOSByMacIn: url [
	^ (url copyReplaceAll: 'linux' with: 'mac') copyReplaceAll: 'win' with: 'mac'
]
