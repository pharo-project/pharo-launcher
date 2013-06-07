initialization
initializePresenter
	super initializePresenter.
	PhLDownloadManager default
		whenErrorAddedDo: [
			statusbarModel content: PhLDownloadManager default numberOfErrors asString, ' network error(s)' ].