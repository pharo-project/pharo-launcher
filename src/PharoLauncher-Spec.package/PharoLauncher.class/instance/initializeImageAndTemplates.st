initialization
initializeImageAndTemplates
	imagesModel
		toolbarCommandClasses: self commandClassesForImagesToolbar;
		menuCommandClasses: self commandClassesForImagesMenu;
		context: self launcherModel;
		repository: self imageRepository.
	templatesModel
		toolbarCommandClasses: self commandClassesForTemplatesToolbar;
		menuCommandClasses: self commandClassesForTemplatesMenu;
		context: self launcherModel;
		repository: self templateRepository.
	statusbarModel
		commandClasses: self commandClassesForStatusbar;
		context: self launcherModel