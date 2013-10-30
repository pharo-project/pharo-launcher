initialization
initializePresenter
	super initializePresenter.
	PhLDownloadManager default whenErrorAddedDo: [ self showNumberOfErrors ].
	self imageRepository whenChangedSend: #updateImages to: self.
	self templateRepository whenChangedSend: #updateTemplates to: self.
	