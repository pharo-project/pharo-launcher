action
launchWithoutSetting
	| vmCommand |
	vmCommand := (PhLVirtualMachineManager forImage: file pathString) vm.
	^ OSProcess command: (self launchCommandWith: vmCommand), ' --no-default-preferences'