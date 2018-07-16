initialization
initializeWidgets

	self initializeToolbar.
	self initializeStatusbar.
	self initializeBody.
	
	propertyPanel := (self instantiate: PhLImagePresenter on: self firstlySelectedImage).

	