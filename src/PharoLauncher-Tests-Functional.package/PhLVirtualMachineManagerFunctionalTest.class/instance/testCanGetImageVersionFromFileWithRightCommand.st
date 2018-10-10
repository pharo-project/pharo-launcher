tests
testCanGetImageVersionFromFileWithRightCommand
	| vmManager command |
	self timeLimit: 30 seconds.
	
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
	command := 'echo 60 > ' , vmManager imageVersionFile fullName surroundedByDoubleQuotes.
		
	self
		assert: (vmManager imageVersionFromFileWith: command)
		equals: '60'