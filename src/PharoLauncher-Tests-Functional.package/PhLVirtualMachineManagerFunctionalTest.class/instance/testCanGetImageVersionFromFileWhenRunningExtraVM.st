tests
testCanGetImageVersionFromFileWhenRunningExtraVM
	| vmManager |
	vmManager := PhDVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
		
	self
		assert: vmManager imageVersion
		equals: self currentImageVersion