querying
availableVirtualMachinesByImageFormat
	^ self availableVirtualMachinesOnDiskByImageFormat
		at: Smalltalk vm imageVersionNumber asString
			ifAbsentPut: Smalltalk vm fullPath;
		yourself