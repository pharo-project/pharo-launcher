Class {
	#name : #PhLLaunchConfigurationTest,
	#superclass : #PhLImageTest,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #helper }
PhLLaunchConfigurationTest >> newVMWith: bytes [

	| file |
	file := FileReference newTempFilePrefix: self class name, '.' suffix: '-vm.bin'.
	file binaryWriteStreamDo: [ :stream | stream nextPutAll: bytes ].
	^ file
]

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
	(fs / PhLImage versionFileName)
		binaryWriteStreamDo: [ :stream | stream nextPutAll: '70' ].
	

]

{ #category : #helper }
PhLLaunchConfigurationTest >> stripExportFrom: arguments [ 
	^ arguments first = 'export'
		ifTrue: [ self stripExportFrom: (arguments allButFirst: 3) "export foo=bar &&" ]
		ifFalse: [ arguments ]
]

{ #category : #'tests - canBeLaunched' }
PhLLaunchConfigurationTest >> testCanBeLaunchedWhenVmAvailable [
	| launchConfig |
	
	self writeIntoVersionFile: '110'.
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	
	self assert: launchConfig canBeLaunched
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
	(fs / PhLImage versionFileName)
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

{ #category : #'tests - canBeLaunched' }
PhLLaunchConfigurationTest >> testCannotLaunchWhen32bitVmFoundAnd64bitArchitectureExpected [
	| launchConfig vm |
	
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	vm := PhLVirtualMachine id: '110-x64'.
	vm be64bits.
	vm executable: (self newVMWith: self vmMac32bitHeader).
	launchConfig vm: vm.
	
	self deny: launchConfig vm isValidForArchitecture.
	self deny: launchConfig canBeLaunched
]

{ #category : #'tests - canBeLaunched' }
PhLLaunchConfigurationTest >> testCannotLaunchWhen64bitVmFoundAnd32bitArchitectureExpected [
	| launchConfig vm |
	
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	vm := PhLVirtualMachine id: '110-x86'.
	vm executable: (self newVMWith: self vmMac64bitHeader).
	launchConfig vm: vm.
	
	self deny: launchConfig vm isValidForArchitecture.
	self deny: launchConfig canBeLaunched
]

{ #category : #'tests - canBeLaunched' }
PhLLaunchConfigurationTest >> testCannotLaunchWhenArmVmFoundAndIntelVmArchitectureDetected [
	| launchConfig vm |
	
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	vm := PhLVirtualMachine id: '110-x64'.
	vm be64bits.
	vm executable: (self newVMWith: self vmMacArm64bitHeader).
	launchConfig vm: vm.
	
	self useIntel64OsArchitectureDuring: [ 
		self deny: launchConfig canBeLaunched ]
		
]

{ #category : #'tests - canBeLaunched' }
PhLLaunchConfigurationTest >> testCannotLaunchWhenVmFoundNotExecutable [
	| launchConfig vm |
	
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	vm := PhLVirtualMachine id: '110-x86'.
	vm executable: (self newVMWith: #[0 1 2 3]).
	launchConfig vm: vm.
	
	self deny: launchConfig vm isValidForArchitecture.
	self deny: launchConfig canBeLaunched
]

{ #category : #'tests - canBeLaunched' }
PhLLaunchConfigurationTest >> testCannotLaunchWhenVmNotValidForArchitecture [
	| launchConfig |
	
	self writeIntoVersionFile: '11'.
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	
	self deny: launchConfig vm isValidForArchitecture.
	self deny: launchConfig canBeLaunched
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

{ #category : #'tests - canBeLaunched' }
PhLLaunchConfigurationTest >> testWarningRaisedWhenIntelVmFoundAndArmVmArchitectureDetected [
	| launchConfig vm |
	
	launchConfig := PhLLaunchConfiguration defaultWithImage: image.
	vm := PhLVirtualMachine id: '110-x64'.
	vm be64bits.
	vm executable: (self newVMWith: self vmMac64bitHeader).
	launchConfig vm: vm.
	
	self useArmOsArchitectureDuring: [ 
		self 
			should: [launchConfig canBeLaunched ]
			raise: PhLTranslatedModeWarning ]
]

{ #category : #helper }
PhLLaunchConfigurationTest >> useArmOsArchitectureDuring: aBlock [
	
	self useOsArchitecture: 'arm64' during: aBlock.
]

{ #category : #helper }
PhLLaunchConfigurationTest >> useIntel64OsArchitectureDuring: aBlock [
	
	self useOsArchitecture: 'x86_64' during: aBlock.
]

{ #category : #helper }
PhLLaunchConfigurationTest >> useOsArchitecture: architectureId during: aBlock [
	
	| currentOsPlatform newOsPlatform |
	
	currentOsPlatform := OSPlatform current.
	newOsPlatform := OSPlatform current class newAnonymousSubclass.
	newOsPlatform compile: 'processorArchitecture ^ ''' , architectureId , ''''.
	[ OSPlatform current: newOsPlatform new.
	aBlock value ]
		ensure: [ OSPlatform current: currentOsPlatform ]
]

{ #category : #'tests - data' }
PhLLaunchConfigurationTest >> vmMac32bitHeader [

	^ #[206 250 237 254 7 0 0 0 3 0 0 0 2 0 0 0 26 0 0 0 128 14 0 0 133 0 0 1 1 0 0 0
56 0 0 0 95 95 80 65 71 69 90 69 82 79 0 0 0 0]
]

{ #category : #'tests - data' }
PhLLaunchConfigurationTest >> vmMac64bitHeader [
	"for Intel processor"
	^ #[207 250 237 254 7 0 0 1 3 0 0 0 2 0 0 0 18 0 0 0 128 7 0 0 133 0 32 0 0 0 0 0
25 0 0 0 72 0 0 0 95 95 80 65 71 69 90 69 82 79]
]

{ #category : #'tests - data' }
PhLLaunchConfigurationTest >> vmMacArm64bitHeader [
	"for ARM processor"
	^ #[207 250 237 254 12 0 0 1 0 0 0 0 2 0 0 0 21 0 0 0 80 6 0 0 133 0 32 0 0 0 0 0
25 0 0 0 72 0 0 0 95 95 80 65 71 69 90 69 82 79]
]

{ #category : #writing }
PhLLaunchConfigurationTest >> writeIntoVersionFile: aString [
	(fs / PhLImage versionFileName)
		binaryWriteStreamDo: [ :stream | stream nextPutAll: aString ]
]
