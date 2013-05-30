updating
saveToFile
	(self baseDirectory / 'cache', 'json') writeStreamDo: [ :aStream | 	dictionary jsonWriteOn: aStream ] 