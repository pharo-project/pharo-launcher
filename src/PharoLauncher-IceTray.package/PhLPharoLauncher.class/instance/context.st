accessing
context
	^ PharoLauncherModel
		selection: imagesTable morph selectedItems
		imageRepository: PhLDirectoryBasedImageRepository default
		templateRepository: PhLTemplateGroupRepository forSelectedGroups