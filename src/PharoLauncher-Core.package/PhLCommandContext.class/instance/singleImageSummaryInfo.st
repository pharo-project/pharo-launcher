selection
singleImageSummaryInfo
	self
		ensure: self hasSingleImageSelected.
	^ self imageRepository summaryInfoForImage: self singleImage