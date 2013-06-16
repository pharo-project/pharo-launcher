as yet unclassified
printOn: aStream
	aStream
		nextPutAll: 'Image (';
		nextPutAll: self name;
		nextPutAll: ')'