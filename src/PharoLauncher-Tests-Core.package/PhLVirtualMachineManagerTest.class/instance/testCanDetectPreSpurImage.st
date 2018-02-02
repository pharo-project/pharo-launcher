tests
testCanDetectPreSpurImage
	| version |
	
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self preSpurHeader.	
	self assert: (PhLVirtualMachineManager isPreSpur: version)