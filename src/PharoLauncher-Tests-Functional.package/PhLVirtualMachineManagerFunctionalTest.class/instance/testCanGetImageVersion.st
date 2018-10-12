tests
testCanGetImageVersion
	| version manager |
	self timeLimit: 30 seconds.
	
	manager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	manager fetchSourcesFilesFor: '61' in: manager compatibleVm vmFolder.

	
	version := (PhLVirtualMachineManager
		forImage: Smalltalk image lastImagePath) imageVersion.
	self assert: version equals: self currentImageVersion