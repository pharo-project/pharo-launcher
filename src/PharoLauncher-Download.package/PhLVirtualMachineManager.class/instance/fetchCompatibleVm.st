private
fetchCompatibleVm
	[ | targetFile | 
	targetFile := self class privateVmStore / (self imageFormatNumber asString , '.zip').
	PhLDownloadManager default 
		download: self compatibleVmUrl
		toFile: targetFile.
	self class
		unzip: targetFile
		to: (self class privateVmStore / self imageFormatNumber asString) ]
	on: KeyNotFound
	do: [ self error: 'No Virtual Machine available for ' , self imageFormatNumber asString, ' image format. Maybe you need to update known formats?' ]