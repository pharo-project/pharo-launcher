tests
testPharo70Vm64BitsUrlIsCorrect
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormat64bits;
		imageVersion: '70';
		vmUrl).
	self 
		assert: (url copyReplaceAll: 'linux' with: 'mac')
		equals: 'http://files.pharo.org/get-files/70/pharo64-mac-stable.zip' 