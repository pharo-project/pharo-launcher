tests
testPharo70VmUrlIsCorrect
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormat32bits;
		imageVersion: '70';
		vmUrl).
	self 
		assert: (url copyReplaceAll: 'linux' with: 'mac')
		equals: 'http://files.pharo.org/get-files/70/pharo-mac-stable.zip' 