tests
testCanDetect64BitsImage
	| version |
	self timeLimit: 60 seconds.
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self sixtyFourBitsHeader.
	self assert: (PhLVirtualMachineManager is64bits: version)