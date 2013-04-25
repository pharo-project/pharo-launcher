items creation
fetchOnlineImage: anURL
	| xmlDoc list |
	xmlDoc := XMLDOMParser parseDocumentFrom: (anURL asUrl retrieveContents).
	list := OrderedCollection new.
	xmlDoc allElementsNamed: #template do: [:each | 
			list add: (ImageLauncherElement
				name: (each nodes elementAt: #name) nodes first
				url: (each nodes elementAt: #url) nodes first
				category: (each nodes elementAt: #category) nodes first)].
	^ list 