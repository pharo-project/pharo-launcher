actions
extractTo: aDirectory named: aString
	"Extract myself to aDirectory. Name the resulting image aString"

	| extractionDirectory |
	extractionDirectory := self extractZipArchive: self zipArchive to: aDirectory.
	self relocateImageFilesFrom: extractionDirectory to: aDirectory withName: aString.
	extractionDirectory deleteAll