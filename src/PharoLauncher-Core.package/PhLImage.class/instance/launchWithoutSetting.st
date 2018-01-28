action
launchWithoutSetting
	[ | vmCommand |
	vmCommand := (PhLVirtualMachineManager forImage: file pathString) vm.
	^ PhLProcessWrapper command: (self launchCommandWith: vmCommand), ' --no-default-preferences' ]
		on: PhLImageVersionDeterminationError 
		do: [ :error | self imageDeterminationErrorAlert: error ]