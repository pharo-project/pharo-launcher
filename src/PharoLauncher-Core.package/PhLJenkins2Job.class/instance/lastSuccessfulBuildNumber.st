accessing
lastSuccessfulBuildNumber
	^ properties at: 'lastSuccessfulBuild'
		ifPresent: [ :dict | dict ifNil: [nil] ifNotNil: [dict at: 'number' ifPresent: [:num | num ] ifAbsent: [ nil ] ]]
		ifAbsent: [ nil ]