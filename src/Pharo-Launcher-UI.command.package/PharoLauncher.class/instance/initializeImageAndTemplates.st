initialization
initializeImageAndTemplates
	imagesModel
		commandClasses: PhLImageCommand allConcreteCommands;
		context: self imageContext.
	templatesModel
		commandClasses: PhLTemplateCommand allConcreteCommands;
		context: self templateContext.
	statusbarModel
		commandClasses: PhLGeneralCommand allConcreteCommands;
		context: self imageContext.