private
extractZipArchive: zipFile to: aDirectory
	"Unzip zipFile inside a temporary subdirectory of aDirectory. Return a reference to the subdirectory. The subdirectory can and must be deleted by the caller"
	| tempDirectory |
	"We have to go through a temporary directory because we don't know where the interesting files are in the archive (maybe at the root or maybe in a subdirectory)"
	tempDirectory := aDirectory / DateAndTime millisecondClockValue asString.
	tempDirectory createDirectory. "will crash if directory already exists. And that's good :-)"
	ZipArchive new
		readFrom: zipFile;
		extractAllTo: tempDirectory.
	^ tempDirectory