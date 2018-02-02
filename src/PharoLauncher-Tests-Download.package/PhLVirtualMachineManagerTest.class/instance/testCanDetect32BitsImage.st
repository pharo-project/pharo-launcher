tests
testCanDetect32BitsImage
	| version |
	
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self thirtyTwoBitsHeader.	
	self assert: (PhLVirtualMachineManager is32bits: version)