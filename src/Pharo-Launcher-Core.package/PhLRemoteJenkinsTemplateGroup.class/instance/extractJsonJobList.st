action
extractJsonJobList
	| queryUrl query |
	query := 'jobs[name,url,lastSuccessfulBuild[runs[artifacts[relativePath],fullDisplayName,url],artifacts[relativePath]]]'.
	queryUrl := url / 'api' / 'json' ? ('tree' -> query).
	^ Json readFrom: queryUrl retrieveContents readStream
	
