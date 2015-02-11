initialization
initializeOnFile: aFile
	aFile exists
		ifTrue: [ aFile readStreamDo: [ :stream | self initializeOnStream: stream ] ]