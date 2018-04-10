printing
printOn: aStream
	aStream
		nextPutAll: 'Image (';
		nextPutAll: self name;
		nextPutAll: ')'