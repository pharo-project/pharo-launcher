tests
testCanDetectVMDirectory
	"WARNING: this test is Linux specific!"
	| vm |
	vm := PhLVirtualMachine directory: Smalltalk imageDirectory asFileReference / 'pharo-vm'.
	self 
		assert: vm vmFolderPath
		equals: Smalltalk vmDirectory fullName