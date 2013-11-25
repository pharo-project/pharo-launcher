instance creation
createLauncher
	^ self basicNew
		setImageRepository: PhLDirectoryBasedImageRepository inPharoPreferencesDirectory
			templateRepository: PhLTemplateGroupRepository forSelectedGroups;
		initialize;
		yourself