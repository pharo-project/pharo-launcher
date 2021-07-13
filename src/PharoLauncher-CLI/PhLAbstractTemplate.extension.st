Extension { #name : #PhLAbstractTemplate }

{ #category : #'*PharoLauncher-CLI' }
PhLAbstractTemplate >> cliPrintOn: aStream [
	aStream nextPutAll: self name.
]
