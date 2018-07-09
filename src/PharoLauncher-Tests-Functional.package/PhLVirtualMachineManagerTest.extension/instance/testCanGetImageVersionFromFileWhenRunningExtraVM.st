*PharoLauncher-Tests-Functional
testCanGetImageVersionFromFileWhenRunningExtraVM
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
		
	self
		assert: vmManager imageVersion
		equals: self currentImageVersion