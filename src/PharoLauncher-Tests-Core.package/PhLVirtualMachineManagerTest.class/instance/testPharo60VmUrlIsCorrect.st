tests
testPharo60VmUrlIsCorrect
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormat32bits;
		imageVersion: '60';
		vmUrl).
	self 
		assert: (url copyReplaceAll: 'linux' with: 'mac')
		equals: 'http://files.pharo.org/get-files/60/pharo-mac-stable.zip' 