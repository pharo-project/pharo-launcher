action
launch
	| vmCommand |
	vmCommand := (PhLVirtualMachineManager forImage: file pathString) vm.
	^ OSProcess command: (self launchCommandWith: vmCommand)