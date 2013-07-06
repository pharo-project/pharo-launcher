printing
printOn: aStream
	aStream
		nextPutAll: 'Template group (';
		nextPutAll: self name;
		nextPutAll: ')'