tests
testCanGetImageFormatNumber
	| version |
	version := PhLVirtualMachineManager imageFormatNumberFromFile: Smalltalk image lastImagePath.
		
	self assert: version isInteger.
	self
		assert: version
		equals: Smalltalk imageFormatVersion