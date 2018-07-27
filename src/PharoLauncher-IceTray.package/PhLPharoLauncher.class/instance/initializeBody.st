initialization
initializeBody
	imagesTable := self newFTSmartTable.
	self initializeImageTable: imagesTable morph.
	propertyPanel := self instantiate: PhLImagePresenter on: self firstlySelectedImage.
	self refresh