querying
availableVirtualMachinesByImageFormat
	^ self availableVirtualMachinesOnDiskByImageFormat
		at: Smalltalk vm imageVersionNumber 
			ifAbsentPut: Smalltalk vm fullPath;
		yourself