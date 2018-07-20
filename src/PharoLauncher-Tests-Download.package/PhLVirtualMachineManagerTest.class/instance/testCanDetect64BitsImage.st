tests
testCanDetect64BitsImage
	| version |
	self timeLimit: 60 seconds.
	version := PhDVirtualMachineManager imageFormatNumberFromStream: self sixtyFourBitsHeader.
	self assert: (PhDVirtualMachineManager is64bits: version)