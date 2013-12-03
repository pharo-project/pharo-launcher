tests
testRelativePathFromFile
	| confFile configuration baseDirectory |
	
	baseDirectory := FileSystem memory root / 'bar'.
	baseDirectory ensureCreateDirectory.

	(baseDirectory / 'foo.pier') writeStreamDo: [ :stream | stream nextPutAll: 'foo' ].
	
	confFile := baseDirectory / 'pillar-conf.ston'.
	confFile writeStreamDo: [ :stream | stream nextPutAll: '{ #inputFiles : [ "foo.pier" ] }' ].
	configuration := PRSTONExportConfiguration fromFile: confFile.
	
	self assert: configuration inputFiles first exists.