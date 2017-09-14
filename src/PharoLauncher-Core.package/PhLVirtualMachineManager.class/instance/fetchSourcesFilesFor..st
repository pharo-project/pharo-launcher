private
fetchSourcesFilesFor: anImageVersionString
	[ | targetFile | 
	targetFile := (self availableVirtualMachines at: self imageVersion) asFileReference parent.
	PhLDownloadManager default 
		download: (self sourcesFileUrlFor: anImageVersionString)
		toFile: targetFile.
		ZipArchive new
			readFrom: targetFile / 'sources.zip';
			extractAllTo: targetFile
		 ]
	on: KeyNotFound
	do: [ self error: 'No Sources file available for ' , anImageVersionString , ' image.' ]