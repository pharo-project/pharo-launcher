tests
testCanDetectVMDirectory
	"WARNING: this test is Linux specific!"

	| vm |
	vm := PhDVirtualMachine directory: FileLocator imageDirectory asFileReference / 'pharo-vm'.
	self
		assert: vm vmFolderPath
		equals: FileLocator vmDirectory fullName