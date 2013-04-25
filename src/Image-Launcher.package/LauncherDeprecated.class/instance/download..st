downloading
download: anURL

	ZnClient new
		url: anURL ;
		downloadTo:  FileSystem disk workingDirectory fullName.