tests
testGetExceptionWhenRunningImageVersionFromFileWhenFileIsAbsent
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
		
	self
		should: [ vmManager imageVersionFromFile ]
		raise: PhLImageVersionDeterminationError 