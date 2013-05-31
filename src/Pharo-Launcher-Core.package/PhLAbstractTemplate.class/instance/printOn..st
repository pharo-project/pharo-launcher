printing
printOn: aStream
	aStream
		nextPutAll: 'Image template (';
		nextPutAll: name;
		nextPutAll: ')'