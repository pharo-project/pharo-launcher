action
downloadToPositionableStream: anUrl
	^ (self documents at: anUrl) readStream