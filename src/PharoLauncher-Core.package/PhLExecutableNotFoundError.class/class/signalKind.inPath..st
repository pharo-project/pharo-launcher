signalling
signalKind: aKindOfApp inPath: aString
	^ self new
		kindOfApplication: aKindOfApp;
		path: aString;
		signal