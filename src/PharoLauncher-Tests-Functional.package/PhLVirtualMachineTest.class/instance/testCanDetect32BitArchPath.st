tests
testCanDetect32BitArchPath
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x86';
		yourself.
	self 
		assert: vm archPath
		equals: ''