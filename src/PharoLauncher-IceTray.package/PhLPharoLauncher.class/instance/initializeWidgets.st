initialization
initializeWidgets

	propertyPanel := (self instantiate: PhLImagePresenter on: self).

	self initializeToolbar.
	self initializeStatusbar.
	self initializeBody