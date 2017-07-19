private
fetchVm
	[ | targetFile | 
	targetFile := self vmStore / (self imageVersion , '.zip').
	PhLDownloadManager default 
		download: self vmUrl
		toFile: targetFile.
	ZipArchive new
		readFrom: targetFile;
		extractAllTo: (self vmStore / self imageVersion) ensureCreateDirectory ]
	on: KeyNotFound
	do: [ self error: 'No Virtual Machine available for ' , self imageVersion , ' image.' ]