protected
jsonQuery: query
	| queryUrl |
	queryUrl := self url / 'api' / 'json' ? ('tree' -> query).
	^ STONJSON
		fromStream: (PhLDownloadManager default downloadToPositionableStream: queryUrl mimeType: ZnMimeType applicationJson)