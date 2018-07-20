tests
testPharo50PreSpurImageUrlIsCorrect
	| url |
	url := PhDVirtualMachineManager new
		imageFormatNumber: PhDVirtualMachineManager imageFormatPreSpur;
		imageVersion: '50';
		vmUrl.
	self assert: (self replaceOSByMacIn: url) equals: 'https://files.pharo.org/get-files/50-preSpur/pharo-mac-stable.zip'