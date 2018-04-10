private
cleanLDLibraryPath
	^ (self currentLDLibraryPathes
		reject: [ :path | path asByteArray utf8Decoded = Smalltalk vmDirectory pathString ])
