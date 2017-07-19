querying
vm
	^ self availableVirtualMachines 
		at: self imageVersion
		ifAbsent: 
			[ | vmPath |
			self fetchVm.
			vmPath := self availableVirtualMachines at: self imageVersion.
			self ensureIsExecutable: vmPath.
			self fetchSourcesFiles.
			vmPath ]