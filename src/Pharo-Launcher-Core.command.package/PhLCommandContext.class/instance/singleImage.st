accessing
singleImage
	self
		ensure: self hasSingleImageSelected.
	^ selection anyOne