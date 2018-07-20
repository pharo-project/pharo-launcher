tests
testCanGetImageFormatNumber
	| version |
	version := PhDVirtualMachineManager imageFormatNumberFromFile: Smalltalk image lastImagePath.
		
	self assert: version isInteger.
	self
		assert: version
		equals: Smalltalk imageFormatVersion