tests
testRelativePath
	| ston configuration baseDirectory |
	ston := '{ #inputFiles : [ "foo.pier" ] }'.
	configuration := self fromString: ston.
	baseDirectory := FileSystem memory root / 'bar'.
	baseDirectory ensureCreateDirectory.
	(baseDirectory / 'foo.pier') writeStreamDo: [ :stream | stream nextPutAll: 'foo' ].
	self deny: configuration inputFiles first exists.
	configuration baseDirectory: baseDirectory.
	self assert: configuration inputFiles first exists.