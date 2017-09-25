querying
availableVirtualMachinesByImageFormat
	^ self availableVirtualMachinesOnDiskByImageFormat
		at: Smalltalk vm imageVersionNumber asString
			ifAbsentPut: (PhLVirtualMachine directory: Smalltalk vmDirectory asFileReference);
		yourself