private
prepareForNewImageNamed: aString
	^ (self directoryForImageNamed: aString) ensureCreateDirectory