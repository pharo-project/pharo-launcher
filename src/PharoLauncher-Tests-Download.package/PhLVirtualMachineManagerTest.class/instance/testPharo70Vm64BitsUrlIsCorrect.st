tests
testPharo70Vm64BitsUrlIsCorrect
	| url |
	url := (PhDVirtualMachineManager new 
		imageFormatNumber: PhDVirtualMachineManager imageFormat64bits;
		imageVersion: '70';
		vmUrl).
	self 
		assert: (self replaceOSByMacIn: url)
		equals: 'https://files.pharo.org/get-files/70/pharo64-mac-stable.zip' 