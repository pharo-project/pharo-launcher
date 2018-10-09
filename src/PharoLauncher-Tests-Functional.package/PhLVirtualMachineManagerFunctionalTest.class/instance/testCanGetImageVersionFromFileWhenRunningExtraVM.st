tests
testCanGetImageVersionFromFileWhenRunningExtraVM
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.

	self flag: 'Remove the following instruction once we based Pharo Launcher on Pharo 7: sources file comes with the image. It is actually needed so that the launched image can get environment variables from the system at startup.'.	
	{ vmManager compatibleVm vmFolder . Smalltalk vmBinary parent asFileReference }
		do: [ :each | vmManager fetchSourcesFilesFor: '61' in: each ].

	
	self
		assert: vmManager imageVersion
		equals: self currentImageVersion