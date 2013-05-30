registry
dictionary 
	^ self cacheFile readStreamDo: [ :aStream | Json readFrom: aStream ]