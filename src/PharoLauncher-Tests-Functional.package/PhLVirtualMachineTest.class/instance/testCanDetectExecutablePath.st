tests
testCanDetectExecutablePath
	"WARNING: this test is Linux specific!"
	| vm vmFolder |
	vmFolder := FileLocator imageDirectory asFileReference / 'pharo-vm'.
	vm := PhDVirtualMachine directory: vmFolder.
	self 
		assert: vm executablePath
		equals: (vmFolder / PhDVirtualMachine executableName) fullName