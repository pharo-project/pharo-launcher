accessing
newTemplateName
	^ newTemplateName ifNil: [ newTemplateName := context requestNewTemplateName: context singleImageName ]