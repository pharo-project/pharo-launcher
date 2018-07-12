actions
deleteSelectedImage
	PhLDeleteImageCommand new
		setContext: self context;
		execute.
	self refresh