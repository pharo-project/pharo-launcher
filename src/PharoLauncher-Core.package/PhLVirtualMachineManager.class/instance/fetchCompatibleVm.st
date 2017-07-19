private
fetchCompatibleVm
	[ | targetFile | 
	targetFile := self privateVmStore / (self imageFormatNumber asString , '.zip').
	PhLDownloadManager default 
		download: self compatibleVmUrl
		toFile: targetFile.
	ZipArchive new
		readFrom: targetFile;
		extractAllTo: (self privateVmStore / self imageFormatNumber asString) ensureCreateDirectory ]
	on: KeyNotFound
	do: [ self error: 'No Virtual Machine available for ' , self imageFormatNumber asString, ' image format. Maybe you need to update known formats?' ]