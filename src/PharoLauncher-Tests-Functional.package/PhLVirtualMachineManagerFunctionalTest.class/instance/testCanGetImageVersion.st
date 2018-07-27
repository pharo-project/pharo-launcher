tests
testCanGetImageVersion
	| version |
	version := (PhDVirtualMachineManager
		forImage: Smalltalk image lastImagePath) imageVersion.
	self assert: version equals: self currentImageVersion