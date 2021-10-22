Class {
	#name : #PhLLaunchConfigurationTest,
	#superclass : #PhLImageTest,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #helper }
PhLLaunchConfigurationTest >> pharo80HeadlessVm [
	^ (PhLVirtualMachine id: '80-x64-headless')
			beHeadless;
			beLatest;
			be64bits;
			isValidAfterUpdate;
			yourself
]

{ #category : #running }
PhLLaunchConfigurationTest >> setUp [
	super setUp.
	(fs / 'pharo.version')
		binaryWriteStreamDo: [ :stream | stream nextPutAll: '70' ].
	

]

{ #category : #helper }
PhLLaunchConfigurationTest >> stripExportFrom: arguments [ 
	^ arguments first = 'export'
		ifTrue: [ self stripExportFrom: (arguments allButFirst: 3) "export foo=bar &&" ]
		ifFalse: [ arguments ]
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
PhLLaunchConfigurationTest >> testCanSerializeLaunchConfiguration [
	| launchConfig deserializedConfig |
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	launchConfig vm executable: 'pharo'.
	launchConfig
		vmArguments: #(1 2 3);
		imageArguments: #(#A #B).
	
	deserializedConfig := STON fromString: (STON toStringPretty: launchConfig).
	
	self
		assert: deserializedConfig name 
		equals: launchConfig name.
	self
		assertCollection: deserializedConfig vmArguments
		hasSameElements: launchConfig vmArguments.
	self
		assertCollection: deserializedConfig imageArguments
		hasSameElements: launchConfig imageArguments.
	self 
		assert: deserializedConfig vm
		equals: launchConfig vm
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchProcessDoesNotHaveInitializationScriptArgumentsIfInitializationScriptIsNil [
	| command launchConfig arguments |
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '80' ].
	launchConfig := image defaultLaunchConfiguration.
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	arguments := self stripExportFrom: command arguments.
	
	self 
		assert: arguments size
	 	equals: 2.
	self deny: (arguments includes: 'eval').
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchProcessDoesNotHaveInitializationScriptArgumentsIfInitializationScriptShouldNotBeRun [
	| command launchConfig arguments |
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '80' ].
	image 
		initializationScript: (FileSystem memory root / 'foo.st') asFileReference;
		doNotRunInitializationScript.
	launchConfig := image defaultLaunchConfiguration.
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	arguments := self stripExportFrom: command arguments.
	
	self 
		assert: arguments size
	 	equals: 2.
	self deny: (arguments includesAny: #('eval' '"/foo.st')).
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
PhLLaunchConfigurationTest >> testImageLaunchProcessHasInitializationScriptArgumentsIfInitializationScriptNotNil [
	| command launchConfig |
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '80' ].
	image initializationScript: (FileSystem memory root / 'foo.st') asFileReference.
	launchConfig := image defaultLaunchConfiguration.
	launchConfig vm executable: 'pharo'.
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	
	self 
		assertCollection: (command arguments last: 2) "remove vm and image argument (and possible exports)"
	 	hasSameElements: #('eval' '"/foo.st"').
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
	| command launchConfig |
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
	| command launchConfig |
	image := PhLImage example32.
	image versionFile writeStreamDo: [ :stream | stream nextPutAll: '20' ].
	launchConfig := image defaultLaunchConfiguration.
	launchConfig doNotUseSettings.
	[ launchConfig vm executable: 'pharo' ]
		on: PhLArchitectureMismatchWarning 
		do: [ :error | error resume. "ignore" ].
	
	[ command := launchConfig launchProcess ]
	on: PhLMissingVirtualMachineError 
	do: [ :error | error resume. "ignore. We are just testing command arguments" ].
	
	self deny: (command arguments includes: '--no-default-preferences')
]

{ #category : #tests }
PhLLaunchConfigurationTest >> testImageLaunchWithoutSettingsHasNoPreferencesFlag [
	| command launchConfig |
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
