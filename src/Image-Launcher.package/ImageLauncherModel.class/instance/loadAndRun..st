runnnig
loadAndRun: anElement
	self download: anElement url asString.
	self unzip: anElement url asString asZnUrl lastPathSegment .
	self run: anElement name asString, '.image'.