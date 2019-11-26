Class {
	#name : #PhLLaunchConfigurationTest,
	#superclass : #PhLImageTest,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #running }
PhLLaunchConfigurationTest >> setUp [
	super setUp.
	(fs / 'pharo.version')
		binaryWriteStreamDo: [ :stream | stream nextPutAll: '70' ].
	

]

{ #category : #tests }
PhLLaunchConfigurationTest >> testCanGetDefaultVm [
	| launchConfig vm |
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	
	vm := launchConfig vm.
	
	self assert: (vm isKindOf: PhLVirtualMachine).
	self 
		assert: vm id
		equals: '70-x64'.
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testCanGetDefaultVmWhenVMNotListedInVmManager [
	| launchConfig vm |
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	(fs / 'pharo.version')
		binaryWriteStreamDo: [ :stream | stream nextPutAll: '770' ].

	vm := launchConfig vm.
	
	self assert: (vm isKindOf: PhLVirtualMachine).
	self 
		assert: vm id
		equals: '770-x64'.
]
