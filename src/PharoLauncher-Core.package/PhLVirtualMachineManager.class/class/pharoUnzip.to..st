unzipping
pharoUnzip: aZipFileReference to: outputDirectory
	ZipArchive new
		readFrom: aZipFileReference;
		extractAllTo: outputDirectory