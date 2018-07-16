actions
deleteSelectedImage
	PhLDeleteImageCommand new
		setModel: self context;
		execute.
	self refresh