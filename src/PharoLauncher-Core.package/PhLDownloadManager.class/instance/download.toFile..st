action
download: url toFile: destinationFile
	destinationFile ensureDelete. "ensure download will not fail if zip file already exists"
	self displayProgressDuring: [ (self newHTTPClientForUrl: url) downloadTo: destinationFile ]