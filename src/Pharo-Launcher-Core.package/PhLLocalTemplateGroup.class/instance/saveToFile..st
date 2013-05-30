updating
saveToFile: aDictionary
	self cacheFile writeStreamDo: [ :aStream | 	aDictionary jsonWriteOn: aStream ] 