private
downloadFailureForUrl: url
	semaphore critical: [ errors add: url ].
	PhLDownloadError signalUrl: url