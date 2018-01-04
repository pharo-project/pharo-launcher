tests
testCanGetImageVersion
	| version |
	version := (PhLVirtualMachineManager
		forImage: Smalltalk image lastImagePath) imageVersion.
	self assert: version equals: self currentImageVersion