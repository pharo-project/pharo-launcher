action
createImageFromTemplate
	| name |
	name := UIManager default request: 'Image name?'.
	imageGroup extractTemplate: self selectedTemplate to: name.
	self updateAll