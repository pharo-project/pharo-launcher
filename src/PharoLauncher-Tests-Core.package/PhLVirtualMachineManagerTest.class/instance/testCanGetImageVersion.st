tests
testCanGetImageVersion
	| version |
	version := (PhLVirtualMachineManager forImage: Smalltalk image lastImagePath) imageVersion.
		
	self
		assert: version
		equals: SystemVersion current major asString, SystemVersion current minor asString 