private
fetchVm
	[ | targetFile | 
	targetFile := self vmStore / (self vmFileName , '.zip').
	PhLDownloadManager default 
		download: self vmUrl
		toFile: targetFile.
	self class
		unzip: targetFile
		to: (self vmStore / self vmFileName) ]
	on: KeyNotFound
	do: [ self error: 'No Virtual Machine available for ' , self imageVersion , ' image.' ]