action
prepareForNewImageNamed: aString
	^ (self baseDirectory / aString) ensureDirectory.