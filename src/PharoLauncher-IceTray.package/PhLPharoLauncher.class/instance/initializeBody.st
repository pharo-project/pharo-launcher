initialization
initializeBody
	imagesTable := self newFTSmartTable.
	self initializeImageTable: imagesTable morph.
	
	self refresh.
