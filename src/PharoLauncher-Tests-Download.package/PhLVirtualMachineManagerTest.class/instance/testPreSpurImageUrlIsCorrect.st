tests
testPreSpurImageUrlIsCorrect
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormatPreSpur;
		imageVersion: '40';
		vmUrl).
	self 
		assert: (self replaceOSByMacIn: url)
		equals: 'https://files.pharo.org/get-files/40/pharo-mac-stable.zip' 