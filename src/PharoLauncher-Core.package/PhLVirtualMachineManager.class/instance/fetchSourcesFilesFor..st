private
fetchSourcesFilesFor: anImageVersionString
	[ | vmFolder sourcesZip |
	vmFolder := (self availableVirtualMachines at: self vmFileName) vmFolderPath.
	sourcesZip := vmFolder / ('sourcesV' , anImageVersionString , '.zip').
	PhLDownloadManager default
		download: (self sourcesFileUrlFor: anImageVersionString)
		toFile: sourcesZip.
	self class
		unzip: sourcesZip
		to: vmFolder ]
		on: KeyNotFound
		do: [ self error: 'No Sources file available for ' , anImageVersionString , ' image.' ]