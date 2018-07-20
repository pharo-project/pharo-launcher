tests
testGetExceptionWhenRunningImageVersionFromFileWithBadCommand
	| vmManager |
	vmManager := PhDVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
	
	self
		should: [ vmManager imageVersionFromFileWith: 'foo' ]
		raise: PhDImageVersionDeterminationError 