unzipping
unzip: anURL

	GZipReadStream 
		saveContents: (FileSystem disk workingDirectory/ anURL, 'zip' ) fullName.