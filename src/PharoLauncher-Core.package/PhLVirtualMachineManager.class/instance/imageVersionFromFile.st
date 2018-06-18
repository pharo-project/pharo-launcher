accessing
imageVersionFromFile
	self imageVersionFile 
			readStreamDo: [ :stream | imageVersion := stream contents asInteger asString ]
			ifAbsent: [ PhLImageVersionDeterminationError signal: 
				('Cannot determine image version: image version file "{1}" not found!' format: { self imageVersionFile pathString }) ].
	^ imageVersion