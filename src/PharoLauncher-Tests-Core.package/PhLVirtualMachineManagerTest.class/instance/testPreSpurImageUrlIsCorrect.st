tests
testPreSpurImageUrlIsCorrect
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormatPreSpur;
		imageVersion: '40';
		vmUrl).
	self 
		assert: (url copyReplaceAll: 'linux' with: 'mac')
		equals: 'http://files.pharo.org/get-files/40/pharo-mac-stable.zip' 