instance creation
newImageTreeNodeName
	^ newImageTreeNodeName ifNil: [ newImageTreeNodeName := context requestNewImageTreeNodeName ]