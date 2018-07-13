accessing
newImageName
	^ newImageName ifNil: [ newImageName := self model requestNewImageName: self model singleImageName ]