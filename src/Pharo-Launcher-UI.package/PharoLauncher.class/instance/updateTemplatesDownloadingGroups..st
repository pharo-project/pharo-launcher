updating
updateTemplatesDownloadingGroups: aBoolean
	aBoolean
		ifTrue: [ 
			PhLDownloadManager default reset.
			templateRepository refresh.
			self showDownloadInProgress.
			templatesModel roots: templateRepository groups.
			self showNumberOfErrors ]
		ifFalse: [ 
			templateRepository reset.
			templatesModel roots: templateRepository groups ]