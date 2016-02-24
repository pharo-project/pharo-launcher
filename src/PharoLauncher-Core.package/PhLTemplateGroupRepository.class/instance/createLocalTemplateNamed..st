action
createLocalTemplateNamed: aString
	| localTemplate |
	localTemplate := PhLLocalTemplate name: aString zipFile: PhLLocalTemplateGroup default baseDirectory / aString , 'zip'.
	PhLLocalTemplateGroup default register: localTemplate withZip: localTemplate zipArchive