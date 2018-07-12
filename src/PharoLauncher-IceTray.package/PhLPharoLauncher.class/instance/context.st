accessing
context
	^ PhLCommandContext
		selection: imagesTable morph selectedItems
		imageRepository: PhLDirectoryBasedImageRepository default
		templateRepository: PhLTemplateGroupRepository forSelectedGroups