tests
replaceOSByMacIn: url
	^ (url copyReplaceAll: 'linux' with: 'mac') copyReplaceAll: 'win' with: 'mac'