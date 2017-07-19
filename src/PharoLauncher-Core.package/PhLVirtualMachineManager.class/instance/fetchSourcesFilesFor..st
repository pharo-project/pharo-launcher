private
fetchSourcesFilesFor: anImageVersionString
	[ | targetFile | 
	targetFile := self vmStore / self imageVersion.
	PhLDownloadManager default 
		download: (self sourcesFileUrlFor: anImageVersionString)
		toFile: targetFile ]
	on: KeyNotFound
	do: [ self error: 'No Sources file available for ' , anImageVersionString , ' image.' ]