protected
jsonQuery: query
	| queryUrl |
	queryUrl := self url / 'api' / 'json' ? ('tree' -> query).
	^ Json
		readFrom: (PhLDownloadManager default downloadToPositionableStream: queryUrl mimeType: ZnMimeType applicationJson)