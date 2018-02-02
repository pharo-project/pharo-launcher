menu
templatesMenu: menu
	self
		buildMenu: menu
		forCommandClasses: PhLTemplateCommand allConcreteCommands
		andSelection: self templatesModel selectedItems