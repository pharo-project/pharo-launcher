instance creation
launcherForAllRepositories
	^ self basicNew
			setTemplateGroup: PhLTemplateGroupRepository all
			imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			initialize;
			yourself