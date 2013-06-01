opening
openAll
	^ self new
			setTemplateGroup: PhLTemplateGroupRepository all
			imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			open