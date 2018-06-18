accessing
imageDescription
	| description |
	[ self imageDescriptionFile
		readStreamDo: [ :stream | description := stream contents ] ]
		on: Error
		do: [ description := '' ].
	^ description