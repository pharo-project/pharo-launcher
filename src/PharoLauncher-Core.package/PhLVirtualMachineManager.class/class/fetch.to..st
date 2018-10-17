private
fetch: aVmUrl to: vmName
	| targetFile | 
	
	targetFile := self vmStore / (vmName , '.zip').
	PhLDownloadManager default 
		download: aVmUrl
		toFile: targetFile.
	self
		unzip: targetFile
		to: (self vmStore / vmName)