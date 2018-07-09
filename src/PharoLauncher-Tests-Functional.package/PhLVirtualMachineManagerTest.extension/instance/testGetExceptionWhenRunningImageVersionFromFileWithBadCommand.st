*PharoLauncher-Tests-Functional
testGetExceptionWhenRunningImageVersionFromFileWithBadCommand
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
	
	self
		should: [ vmManager imageVersionFromFileWith: 'foo' ]
		raise: PhLImageVersionDeterminationError 