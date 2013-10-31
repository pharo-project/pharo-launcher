initialization
initializeImageAndTemplates
	imagesModel
		commandClasses: PhLImageCommand allConcreteCommands;
		context: self imageContext;
		repository: self imageRepository.
	templatesModel
		commandClasses: PhLTemplateCommand allConcreteCommands;
		context: self templateContext;
		repository: self templateRepository.
	statusbarModel
		commandClasses: PhLGeneralCommand allConcreteCommands;
		context: self imageContext.