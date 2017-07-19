tests
testPharo50PreSpurImageUrlIsCorrect
	| url |
	url := (PhLVirtualMachineManager new 
		imageFormatNumber: PhLVirtualMachineManager imageFormatPreSpur;
		imageVersion: '50';
		vmUrl).
	self 
		assert: (url copyReplaceAll: 'linux' with: 'mac')
		equals: 'http://files.pharo.org/get-files/50-preSpur/pharo-mac-stable.zip' 