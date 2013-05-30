initialize-release
initializeFromJson: aJsonJob
	json := aJsonJob.
	url := (json at: #url) asZnUrl.
	name := (json at: #name)