actions
extractTo: aDirectory named: aString
	"Extract myself to aDirectory. Name the resulting image aString"

	| zipFile extractionDirectory |
	zipFile := self zipArchive.
	extractionDirectory := self extractZipArchive: zipFile to: aDirectory.
	self relocateImageFilesFrom: extractionDirectory to: aDirectory withName: aString.
	self cleaningFilesFrom: aDirectory