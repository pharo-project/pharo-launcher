action
launch
	[ | vmCommand |
	vmCommand := (PhLVirtualMachineManager forImage: file pathString) vm.
	^ PhLProcessWrapper command: (self launchCommandWith: vmCommand) ]
		on: PhLImageVersionDeterminationError
		do: [ :error | self imageDeterminationErrorAlert: error ]