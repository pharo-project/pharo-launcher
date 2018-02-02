instance creation
launcherForAllRepositories
	^ self basicNew
			setImageRepository: PhLTemplateGroupRepository all
			templateRepository: PhLDirectoryBasedImageRepository inPharoPreferencesDirectory;
			initialize;
			yourself