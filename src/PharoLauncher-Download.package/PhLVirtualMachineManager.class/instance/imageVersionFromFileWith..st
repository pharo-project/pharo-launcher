accessing
imageVersionFromFileWith: commandString
	PhLProcessWrapper waitForCommand: commandString.
	self imageVersionFile 
			readStreamDo: [ :stream | imageVersion := stream contents asInteger asString ]
			ifAbsent: [ PhLImageVersionDeterminationError signalCommand: commandString ].
	^ imageVersion