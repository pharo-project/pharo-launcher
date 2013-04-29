unzipping
unzip: anElement
	ZipArchive new
		readFrom: (self imageDirectory / anElement name asString, 'zip');
		extractAllTo: (self imageDirectory / anElement name asString ).
	self rename: (self tmpDirectory: anElement) to: anElement name asString