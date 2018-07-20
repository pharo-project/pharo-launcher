initialization
initializePresenter
	super initializePresenter.
	PhDDownloadManager default whenErrorAddedDo: [ self showNumberOfErrors ].
	