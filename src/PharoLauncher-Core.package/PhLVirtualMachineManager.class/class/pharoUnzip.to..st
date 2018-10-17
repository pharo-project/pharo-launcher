unzipping
pharoUnzip: aZipFileReference to: outputDirectory
	UIManager default informUserDuring: 
		[ :bar | 
		ZipArchive new
			readFrom: aZipFileReference;
			extractAllTo: outputDirectory informing: bar overwrite: true ]
	