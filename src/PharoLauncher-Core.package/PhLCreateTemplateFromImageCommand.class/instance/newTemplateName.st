accessing
newTemplateName
	^ newTemplateName ifNil: [ newTemplateName := self model requestNewTemplateName: self model singleImageName ]