actions
extractTo: aDirectory named: aString
	
	
	| zipFile extractionDirectory |
	zipFile := self putZipArchiveIn: aDirectory.
	extractionDirectory := self extractZipArchive: zipFile to: aDirectory.
	self relocateImageFilesFrom: extractionDirectory to: aDirectory withName: aString.
	self cleaningFilesFrom: aDirectory.
	