tests
testCanDetectPreSpurImage
	| version |
	self timeLimit: 60 seconds.
	version := PhDVirtualMachineManager imageFormatNumberFromStream: self preSpurHeader.	
	self assert: (PhDVirtualMachineManager isPreSpur: version)