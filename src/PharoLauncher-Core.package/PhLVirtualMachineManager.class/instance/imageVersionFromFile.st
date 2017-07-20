accessing
imageVersionFromFile
	self imageVersionFile 
			readStreamDo: [ :stream | imageVersion := stream contents asInteger asString ]
			ifAbsent: [ ^ nil ].
	^ imageVersion