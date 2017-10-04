querying
availableVirtualMachinesByImageFormat
	^ self availableVirtualMachinesOnDiskByImageFormat
		at: Smalltalk vm imageVersionNumber asString
			ifAbsentPut: (PhLVirtualMachine directory: Smalltalk vmBinary parent asFileReference);
		yourself