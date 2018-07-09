private
saveToFile: aDictionary
	self cacheFile writeStreamDo: [ :aStream | 	STONJSON put: aDictionary onStream: aStream ] 