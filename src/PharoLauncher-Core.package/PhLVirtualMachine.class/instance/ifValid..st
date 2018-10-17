testing
ifValid: aBlockClosure 
	(executableRef isNotNil and: [ vmBinaryRef isNotNil ])
		ifTrue: [ aBlockClosure value ]