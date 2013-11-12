initialization
initializeImageAndTemplates
	imagesModel
		toolbarCommandClasses: self commandClassesForImagesToolbar;
		menuCommandClasses: self commandClassesForImagesMenu;
		context: self newInitialContext;
		repository: self imageRepository.
	templatesModel
		toolbarCommandClasses: self commandClassesForTemplatesToolbar;
		menuCommandClasses: self commandClassesForTemplatesMenu;
		context: self newInitialContext;
		repository: self templateRepository.
	statusbarModel
		commandClasses: PhLGeneralCommand allConcreteCommands;
		context: self newInitialContext