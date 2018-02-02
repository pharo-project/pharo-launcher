initialization
initializeImageAndTemplates
	imagesModel
		commandClasses: PhLImageCommand allConcreteCommands;
		context: self newInitialContext;
		repository: self imageRepository.
	templatesModel
		commandClasses: PhLTemplateCommand allConcreteCommands;
		context: self newInitialContext;
		repository: self templateRepository.
	statusbarModel
		commandClasses: PhLGeneralCommand allConcreteCommands;
		context: self newInitialContext.