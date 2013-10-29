accessing
newImageName
	^ newImageName ifNil: [ newImageName := context requestNewImageName: context singleImage name ]