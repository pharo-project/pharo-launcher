helpers
downloadManager
	| manager |
	manager := PhDDownloadManager default.
	"If this assertion fails, you probably need to add a setUp method which calls PhLDownloadManagerMock>>install."
	self assert: (manager isKindOf: PhLDownloadManagerMock).
	^ manager