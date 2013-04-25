unzipping
unzip: aFileName
	ZipArchive  
		extractAllIn: (FileSystem disk workingDirectory/ aFileName) fullName.