private
dictionary
	^ self cacheFile
		readStreamDo: [ :aStream | 
			aStream atEnd
				ifTrue: [ Dictionary new ]
				ifFalse: [ Json readFrom: aStream ] ]