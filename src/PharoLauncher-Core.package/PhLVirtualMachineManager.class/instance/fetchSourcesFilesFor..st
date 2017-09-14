private
fetchSourcesFilesFor: anImageVersionString
	[ | vmFolder sourcesZip |
	vmFolder := (self availableVirtualMachines at: self imageVersion) asFileReference parent.
	sourcesZip := vmFolder / ('sourcesV' , anImageVersionString , '.zip').
	PhLDownloadManager default
		download: (self sourcesFileUrlFor: anImageVersionString)
		toFile: sourcesZip.
	ZipArchive new
		readFrom: sourcesZip;
		extractAllTo: vmFolder ]
		on: KeyNotFound
		do: [ self error: 'No Sources file available for ' , anImageVersionString , ' image.' ]