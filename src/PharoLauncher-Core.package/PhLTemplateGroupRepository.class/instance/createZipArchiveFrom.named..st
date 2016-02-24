action
createZipArchiveFrom: anImage named: aString
	ZipArchive new
		addFile: anImage imageFile as: aString , '.image';
		addFile: anImage changesFile as: aString , '.changes';
		writeToFileNamed: PhLLocalTemplate default baseDirectory / aString , 'zip'