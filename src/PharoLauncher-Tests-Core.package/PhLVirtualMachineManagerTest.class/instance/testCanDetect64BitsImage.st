tests
testCanDetect64BitsImage
	| version |
	
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self sixtyFourBitsHeader.	
	self assert: (PhLVirtualMachineManager is64bits: version)