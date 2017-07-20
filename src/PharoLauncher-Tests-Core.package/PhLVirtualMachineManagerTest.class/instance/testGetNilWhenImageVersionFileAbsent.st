tests
testGetNilWhenImageVersionFileAbsent
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
		
	self
		assert: vmManager imageVersionFromFile
		equals: nil