tests
testCanDetect64BitArchPath
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x64';
		yourself.
	self 
		assert: vm archPath
		equals: '64'