accessing
baseDirectory
	^ (FileLocator preferences / 'pharo' / 'templateCache') ensureCreateDirectory