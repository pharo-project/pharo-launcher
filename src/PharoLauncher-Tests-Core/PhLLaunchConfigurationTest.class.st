Class {
	#name : #PhLLaunchConfigurationTest,
	#superclass : #PhLImageTest,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLLaunchConfigurationTest >> pharo80HeadlessVm [
	^ PhLVirtualMachineManager new virtualMachines
		detect: [ :each | each id = '80-x64-headless' ]
		ifFound: [ :vm | vm isValidAfterUpdate. vm ]
		ifNone: [ self fail: 'cannot find VM!' ]
]

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

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchProcessHasImageArguments [
	| command launchConfig |
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '80' ].
	launchConfig := image defaultLaunchConfiguration.
	launchConfig imageArguments: #( 1 2 3 ).
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	
	self assert: (command arguments includesAll: #( 1 2 3 )).
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchProcessHasVmArguments [
	| command launchConfig |
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '80' ].
	launchConfig := image defaultLaunchConfiguration.
	launchConfig 
		doNotUseSettings;
		vm: self pharo80HeadlessVm.
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	
	self assert: (command arguments includes: PhLVirtualMachine headlessOptionString)
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchWitSettingsDoesNotHaveNoPreferencesFlag [
	| image command launchConfig |
	image := PhLImage example.
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	launchConfig := image defaultLaunchConfiguration.
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	
	self deny: (command arguments includes: '--no-default-preferences')
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchWithoutSettingsDoesNotHavePreferencesFlagIfNotSupportedByImage [
	| image command launchConfig |
	image := PhLImage example32.
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '20' ].
	launchConfig := image defaultLaunchConfiguration.
	launchConfig doNotUseSettings.
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	
	self deny: (command arguments includes: '--no-default-preferences')
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchWithoutSettingsHasNoPreferencesFlag [
	| image command launchConfig |
	image := PhLImage example.
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	launchConfig := image defaultLaunchConfiguration.
	launchConfig doNotUseSettings.
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	
	self assert: (command arguments includes: '--no-default-preferences')
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testVmHasSameVmManagerAsImage [
	| launchConfig |
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	launchConfig vm executable: 'pharo'.
	
	self 
		assert: launchConfig image vmManager
		identicalTo: launchConfig vm manager
]
