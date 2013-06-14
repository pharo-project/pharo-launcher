initialization
initializePresenter
	super initializePresenter.
	PhLDownloadManager default whenErrorAddedDo: [ self showNumberOfErrors ]