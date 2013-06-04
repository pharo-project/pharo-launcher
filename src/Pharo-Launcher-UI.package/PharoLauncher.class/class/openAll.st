opening
openAll
	^ self basicNew
			setTemplateGroup: PhLTemplateGroupRepository all
			imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			initialize;
			openWithSpec