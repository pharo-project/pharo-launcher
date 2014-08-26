action
newImageName
	^ newImageName ifNil: [ newImageName := context requestNewImageName: context singleTemplateName ]