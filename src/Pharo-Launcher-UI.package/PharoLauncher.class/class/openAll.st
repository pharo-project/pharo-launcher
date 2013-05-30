opening
openAll
	^ self new
			setTemplateGroup: PhLTemplateRepository all
			imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			open