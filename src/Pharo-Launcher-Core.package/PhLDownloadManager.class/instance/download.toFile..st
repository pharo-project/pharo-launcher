action
download: url toFile: destinationFile
	(self newHTTPClientForUrl: url)
		downloadTo: destinationFile