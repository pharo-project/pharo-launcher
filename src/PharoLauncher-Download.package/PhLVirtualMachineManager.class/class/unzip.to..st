unzipping
unzip: aZipFileReference to: outputDirectory
	outputDirectory ensureCreateDirectory.
	self canUseSytemZip
		ifTrue: [ self systemUnzip: aZipFileReference to: outputDirectory ]
		ifFalse: [ self pharoUnzip: aZipFileReference to: outputDirectory ]