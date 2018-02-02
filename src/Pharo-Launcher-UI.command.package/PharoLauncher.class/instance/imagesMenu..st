menu
imagesMenu: menu
	self
		buildMenu: menu
		forCommandClasses: PhLImageCommand allConcreteCommands
		andSelection: self imagesModel selectedItems