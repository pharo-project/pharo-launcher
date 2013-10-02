updating
refreshTemplateGroups
	PhLDownloadManager default reset.
	templateRepository refresh.
	self showDownloadInProgress.
	templatesModel roots: templateRepository groups.
	self showNumberOfErrors