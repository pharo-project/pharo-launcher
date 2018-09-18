tests
testCanGetPharoVersion
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x64';
		yourself.
	self 
		assert: vm pharoVersion
		equals: '70'