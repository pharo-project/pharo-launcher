private
jobs
	"Get the JSON array from the server"

	| queryUrl query |
	"The query is detailed enough to get all the information we want with just one request. If you update this, make sure we always have the 'relativePath' field for each artifact."
	query := 'jobs[name,url,lastSuccessfulBuild[runs[artifacts[relativePath],fullDisplayName,url],artifacts[relativePath]]]'.
	queryUrl := url / 'api' / 'json' ? ('tree' -> query).
	^ Json readFrom: (PhLDownloadManager default downloadToPositionableStream: queryUrl mimeType: ZnMimeType applicationJson).