unzipping
unzip: aFileName
	ZipArchive new
		readFrom: (StartupLoader preferencesGeneralFolder asFileReference / SystemVersion current dottedMajorMinor / aFileName);
		extractAllTo: (StartupLoader preferencesGeneralFolder asFileReference / SystemVersion current dottedMajorMinor).