helpers
addText: aString to: aDocumentItem
	^ aDocumentItem
		add: (PRText content: aString);
		yourself