private
fetchSourcesFilesFor: anImageVersionString
	[ | targetFile | 
	targetFile := self vmStore / self imageVersion.
	ZnClient new
		url: (self sourcesFileUrlFor: anImageVersionString);
		downloadTo: targetFile ]
	on: KeyNotFound
	do: [ self error: 'No Sources file available for ' , anImageVersionString , ' image.' ]