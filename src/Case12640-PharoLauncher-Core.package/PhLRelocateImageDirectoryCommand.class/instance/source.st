accessing
source
	^ source ifNil: [ source := PhLDirectoryBasedImageRepository location ]