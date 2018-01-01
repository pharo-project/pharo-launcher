accessing
baseDirectory

	^ (baseDirectory ifNil: [ self class location ]) ensureCreateDirectory