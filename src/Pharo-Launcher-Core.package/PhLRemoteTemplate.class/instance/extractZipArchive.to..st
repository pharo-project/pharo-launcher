actions
extractZipArchive: zipFile to: aDirectory
	| tempDirectory |
	tempDirectory := aDirectory / DateAndTime millisecondClockValue asString.
	tempDirectory createDirectory. "will crash if directory already exists. And that's good :-)"
	ZipArchive new
		readFrom: zipFile;
		extractAllTo: tempDirectory.
	self saveInTemplateCache: zipFile.
	^ tempDirectory