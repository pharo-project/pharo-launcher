tests
testCanDetectVMDirectory
	"WARNING: this test is Linux specific!"
	| vm |
	vm := PhLVirtualMachine directory: Smalltalk imageDirectory parent asFileReference.
	self 
		assert: vm vmFolderPath
		equals: Smalltalk vmDirectory fullName