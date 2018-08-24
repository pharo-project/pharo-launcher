tests
testCanGetDownloadUrl
	| vm |
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '70-x64';
		yourself.
	self 
		assert: vm downloadUrl 
		equals: 'https://files.pharo.org/get-files/70/pharo64-mac-stable.zip'