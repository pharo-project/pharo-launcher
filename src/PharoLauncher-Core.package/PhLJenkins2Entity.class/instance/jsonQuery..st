protected
jsonQuery: query
	| queryUrl |
	queryUrl := self url / 'api' / 'json' ? ('tree' -> query).
	^ STONJSON
		fromStream: (PhDDownloadManager default downloadToPositionableStream: queryUrl mimeType: ZnMimeType applicationJson)