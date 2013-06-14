private
extractJsonJobList
	"Get the JSON array from the server"
	| queryUrl query |
	query := 'jobs[name,url,lastSuccessfulBuild[runs[artifacts[relativePath],fullDisplayName,url],artifacts[relativePath]]]'.
	queryUrl := url / 'api' / 'json' ? ('tree' -> query).
	^ Json readFrom: (PhLDownloadManager default downloadToPositionableStream: queryUrl)
	
