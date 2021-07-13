Extension { #name : #PhLImage }

{ #category : #'*PharoLauncher-CLI' }
PhLImage >> cliPrintOn: anOutputStream [
	anOutputStream
		nextPutAll: self name;
		tab;
		nextPutAll: 'architecture: ';
		nextPutAll: self architecture.
]
