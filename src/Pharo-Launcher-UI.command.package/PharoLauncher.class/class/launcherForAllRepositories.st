instance creation
launcherForAllRepositories
	^ self basicNew
			setTemplateGroup: PhLTemplateGroupRepository all
			imageGroup: PhLDirectoryBasedImageRepository inPharoPreferencesDirectory;
			initialize;
			yourself