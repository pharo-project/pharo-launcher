tests
testCanDetectExecutablePath
	"WARNING: this test is Linux specific!"
	| vm vmFolder |
	vmFolder := FileLocator imageDirectory asFileReference / 'pharo-vm'.
	vm := PhLVirtualMachine directory: vmFolder.
	self 
		assert: vm executablePath
		equals: (vmFolder / PhLVirtualMachine executableName) fullName