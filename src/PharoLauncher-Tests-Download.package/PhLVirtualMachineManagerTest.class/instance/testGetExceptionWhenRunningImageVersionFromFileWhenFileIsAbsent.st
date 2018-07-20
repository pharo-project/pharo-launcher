tests
testGetExceptionWhenRunningImageVersionFromFileWhenFileIsAbsent
	| vmManager |
	vmManager := PhDVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
		
	self
		should: [ vmManager imageVersionFromFile ]
		raise: PhDImageVersionDeterminationError 