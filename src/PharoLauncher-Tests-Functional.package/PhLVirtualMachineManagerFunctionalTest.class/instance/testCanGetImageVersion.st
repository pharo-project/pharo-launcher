tests
testCanGetImageVersion
	| version manager |

	manager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	manager fetchSourcesFilesFor: '61' in: manager compatibleVm vmFolder.

	
	version := (PhLVirtualMachineManager
		forImage: Smalltalk image lastImagePath) imageVersion.
	self assert: version equals: self currentImageVersion