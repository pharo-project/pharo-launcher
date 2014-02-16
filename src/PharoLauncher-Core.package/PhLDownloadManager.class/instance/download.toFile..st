action
download: url toFile: destinationFile
	self displayProgressDuring: [ (self newHTTPClientForUrl: url) downloadTo: destinationFile ]