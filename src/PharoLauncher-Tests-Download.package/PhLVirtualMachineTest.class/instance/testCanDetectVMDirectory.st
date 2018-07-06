tests
testCanDetectVMDirectory
	"WARNING: this test is Linux specific!"

	| vm |
	vm := PhLVirtualMachine directory: FileLocator imageDirectory asFileReference / 'pharo-vm'.
	self
		assert: vm vmFolderPath
		equals: FileLocator vmDirectory