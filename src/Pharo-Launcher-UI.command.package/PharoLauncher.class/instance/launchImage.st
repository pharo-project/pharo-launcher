image actions
launchImage
	| context |
	context := PhLCommandContext selection: imagesModel selectedItems imageRepository: self imageRepository templateRepository: self templateRepository.
	(PhLLaunchImageCommand on: context) execute