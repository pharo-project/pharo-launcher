private
cleanLDLibraryPath
	^ (self currentLDLibraryPathes
		reject: [ :path | path asByteArray utf8Decoded = FileLocator vmDirectory pathString ])
