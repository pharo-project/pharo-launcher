tests
testPharo60VmUrlIsCorrect
	| url |
	url := PhDVirtualMachineManager new
		imageFormatNumber: PhDVirtualMachineManager imageFormat32bits;
		imageVersion: '60';
		vmUrl.
	self assert: (self replaceOSByMacIn: url) equals: 'https://files.pharo.org/get-files/60/pharo-mac-stable.zip'