tests
testCanDetect64BitsImage
	| version |
	
	ZnConstants defaultMaximumEntitySize: 25 * 1024 * 1024. "25 Mb"
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self sixtyFourBitsHeader.	
	self assert: (PhLVirtualMachineManager is64bits: version)