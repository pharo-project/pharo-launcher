instance creation
createLauncher
	^ self basicNew
		setImageRepository: PhLDirectoryBasedImageRepository default
			templateRepository: PhLTemplateGroupRepository forSelectedGroups;
		initialize;
		yourself