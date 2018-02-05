tests
testPharo60VmUrlIsCorrect
	| url |
	url := PhLVirtualMachineManager new
		imageFormatNumber: PhLVirtualMachineManager imageFormat32bits;
		imageVersion: '60';
		vmUrl.
	self assert: (self replaceOSByMacIn: url) equals: 'https://files.pharo.org/get-files/60/pharo-mac-stable.zip'