instance creation
createLauncher
	| imageRepository templateRepository |
	Transcript cr.
	imageRepository := PhLDirectoryBasedImageRepository default.
	templateRepository := PhLTemplateGroupRepository forSelectedGroups.
	Transcript crShow: thisContext printString , '  imageRepository=' ,  imageRepository hash printString , '   templateRepository=' ,  templateRepository hash printString.
	self halt.
	^ self basicNew
		setImageRepository: imageRepository
			templateRepository: templateRepository ;
		initialize;
		yourself