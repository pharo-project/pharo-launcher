action
createLocalTemplateNamed: aString
	| localTemplate |
	localTemplate := PhLLocalTemplate name: aString zipFile: PhLDownloadedTemplateGroup default baseDirectory / aString , 'zip'.
	PhLDownloadedTemplateGroup default register: localTemplate withZip: localTemplate zipArchive