downloading
download: anURL

	ZnClient new
		url: anURL ;
		downloadTo:  (StartupLoader preferencesGeneralFolder asFileReference / SystemVersion current dottedMajorMinor).