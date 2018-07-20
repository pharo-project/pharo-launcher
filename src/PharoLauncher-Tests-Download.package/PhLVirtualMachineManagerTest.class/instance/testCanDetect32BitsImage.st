tests
testCanDetect32BitsImage
	| version |
	self timeLimit: 60 seconds.
	version := PhDVirtualMachineManager imageFormatNumberFromStream: self thirtyTwoBitsHeader.
	self assert: (PhDVirtualMachineManager is32bits: version)