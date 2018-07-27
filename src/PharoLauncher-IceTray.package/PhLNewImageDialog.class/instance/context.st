initializing
context
	^ PharoLauncherModel
		selection: nil 
		imageRepository: PhLDirectoryBasedImageRepository default
		templateRepository: PhLTemplateGroupRepository forSelectedGroups