tests
testCanGetImageVersion
	| version expected |
	version := (PhLVirtualMachineManager forImage: Smalltalk image lastImagePath) imageVersion.
	expected := SystemVersion current major asString , SystemVersion current minor asString.
	(SystemVersion current major = 6
		and: [ SystemVersion current highestUpdate >= 60509 ])
		ifTrue: [ expected := '61' ].
	self
		assert: version
		equals: expected