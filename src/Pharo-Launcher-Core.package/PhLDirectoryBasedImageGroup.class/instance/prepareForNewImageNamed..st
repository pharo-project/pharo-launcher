private
prepareForNewImageNamed: aString
	^ (self directoryForImageNamed: aString) ensureDirectory