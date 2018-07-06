accessing
zipArchive
	"The local template group takes care of cashing downloaded templates."
	^ PhLDownloadedTemplateGroup default downloadAndStoreFile: url forTemplate: self