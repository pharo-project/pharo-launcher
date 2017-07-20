tests
testCanGetImageVersionFromFile
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile writeStreamDo: [ :stream | stream << '60' ].
		
	self
		assert: vmManager imageVersionFromFile
		equals: '60'