private
fetchSourcesFilesFor: anImageVersionString
	[ | targetFile | 
	targetFile := (self availableVirtualMachines at: self imageVersion) asFileReference parent.
	PhLDownloadManager default 
		download: (self sourcesFileUrlFor: anImageVersionString)
		toFile: targetFile ]
	on: KeyNotFound
	do: [ self error: 'No Sources file available for ' , anImageVersionString , ' image.' ]