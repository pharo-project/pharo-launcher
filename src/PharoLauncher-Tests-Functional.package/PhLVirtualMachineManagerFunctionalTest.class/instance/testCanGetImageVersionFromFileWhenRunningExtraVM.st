tests
testCanGetImageVersionFromFileWhenRunningExtraVM
	| vmManager |
	vmManager := PhLVirtualMachineManager forImage: Smalltalk image lastImagePath.
	vmManager imageVersionFile ensureDelete.
	self flag: 'Remove the following instruction once we based Pharo Launcher on Pharo 7: sources file comes with the image. It is actually needed so that the launched image can get environment variables from the system at startup.'.
	vmManager fetchSourcesFilesFor: '61' in: Smalltalk vmBinary parent asFileReference. 
	
	self
		assert: vmManager imageVersion
		equals: self currentImageVersion