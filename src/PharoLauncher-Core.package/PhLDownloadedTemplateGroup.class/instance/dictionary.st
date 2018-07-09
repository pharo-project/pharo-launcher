private
dictionary
	^ self cacheFile
		readStreamDo: [ :aStream | 
			aStream atEnd
				ifTrue: [ Dictionary new ]
				ifFalse: [ STONJSON fromStream: aStream ] ]