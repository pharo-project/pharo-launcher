instance creation
createLauncher
	^ self basicNew
			setImageRepository: PhLTemplateGroupRepository forSelectedGroups
			templateRepository: PhLDirectoryBasedImageRepository inPharoPreferencesDirectory;
			initialize;
			yourself