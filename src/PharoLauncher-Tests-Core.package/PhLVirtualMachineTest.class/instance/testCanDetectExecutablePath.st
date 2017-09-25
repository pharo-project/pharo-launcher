tests
testCanDetectExecutablePath
	"WARNING: this test is Linux specific!"
	| vm |
	vm := PhLVirtualMachine directory: Smalltalk imageDirectory parent asFileReference.
	self 
		assert: vm executablePath
		equals: (Smalltalk imageDirectory parent / PhLVirtualMachine executableName) fullName