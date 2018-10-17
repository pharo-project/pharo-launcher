private
checkImageArchitecture
	"Only warn on 64-bit Linux"
	Smalltalk os isUnix64 ifFalse: [ ^ self ]. 
	
	" Most OS are now 64-bits. Do not warn if a Pharo Launcher 32-bit tries to run a 64-bit image. "	
	(self class is64bits and: [ self class is32bits: self imageFormatNumber ])
		ifTrue: [ PhLArchitectureMismatchWarning signalLauncherArch: '64-bit' imageArch: '32-bit' ]