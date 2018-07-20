tests
testPharo70VmUrlIsCorrect
	| url |
	url := (PhDVirtualMachineManager new 
		imageFormatNumber: PhDVirtualMachineManager imageFormat32bits;
		imageVersion: '70';
		vmUrl).
	self 
		assert: (self replaceOSByMacIn: url)
		equals: 'https://files.pharo.org/get-files/70/pharo-mac-stable.zip' 