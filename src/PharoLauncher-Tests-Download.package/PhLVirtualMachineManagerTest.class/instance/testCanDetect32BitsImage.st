tests
testCanDetect32BitsImage
	| version |
	self timeLimit: 60 seconds.
	version := PhLVirtualMachineManager imageFormatNumberFromStream: self thirtyTwoBitsHeader.
	self assert: (PhLVirtualMachineManager is32bits: version)