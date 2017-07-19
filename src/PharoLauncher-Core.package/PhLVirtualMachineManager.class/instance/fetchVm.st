private
fetchVm
	[ | targetFile | 
	targetFile := self vmStore / (self imageVersion , '.zip').
	ZnClient new
		url: self vmUrl;
		downloadTo: targetFile.
	ZipArchive new
		readFrom: targetFile;
		extractAllTo: (self vmStore / self imageVersion) ensureCreateDirectory ]
	on: KeyNotFound
	do: [ self error: 'No Virtual Machine available for ' , self imageVersion , ' image.' ]