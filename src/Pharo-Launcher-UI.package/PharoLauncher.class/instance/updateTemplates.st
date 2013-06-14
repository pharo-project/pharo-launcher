updating
updateTemplates
	Halt once.
	PhLDownloadManager default reset.
	templateRepository reset.
	self showDownloadInProgress.
	templatesModel roots: templateRepository groups.
	self showNumberOfErrors.