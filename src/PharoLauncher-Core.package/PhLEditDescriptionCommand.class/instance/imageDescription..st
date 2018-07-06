accessing
imageDescription: description
	self imageDescriptionFile
		writeStreamDo: [ :stream | stream nextPutAll: description ]