menu
templatesMenu: menu
	self selectedTemplate
		ifNotNil: [ :template | template populateMenu: menu on: self ]