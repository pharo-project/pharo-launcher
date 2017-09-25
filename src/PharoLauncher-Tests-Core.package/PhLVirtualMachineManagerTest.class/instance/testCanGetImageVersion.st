tests
testCanGetImageVersion
	| version expectedVersion |
	version := (PhLVirtualMachineManager forImage: Smalltalk image lastImagePath) imageVersion.
	
	expectedVersion := (SystemVersion current major = 6 
			and: [ SystemVersion current highestUpdate >= 60509 ])
		ifTrue: [ '61' ]
		ifFalse: [ SystemVersion current major asString, SystemVersion current minor asString ].
	self
		assert: version
		equals: expectedVersion.