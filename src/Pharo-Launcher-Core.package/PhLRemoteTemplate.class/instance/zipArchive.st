accessing
zipArchive
	"The local template group takes care of cashing downloaded templates."
	^ PhLLocalTemplateGroup default downloadAndStoreFile: url forTemplate: self