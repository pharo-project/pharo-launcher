instance creation
createLauncher
	^ self basicNew
		setImageRepository: PhLDirectoryBasedImageTreeRepository default
			templateRepository: PhLTemplateGroupRepository forSelectedGroups;
		initialize;
		yourself