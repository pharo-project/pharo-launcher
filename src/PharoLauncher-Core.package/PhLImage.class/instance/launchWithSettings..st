action
launchWithSettings: usePharoSettings
	[ | vmCommand |
	vmCommand := (PhLVirtualMachineManager forImage: file pathString) vm.
	^ PhLProcessWrapper command: (self launchCommandWith: vmCommand useSettings: usePharoSettings) ]
		on: PhLImageVersionDeterminationError
		do: [ :error |  error uiAlert ]