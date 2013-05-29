remote action
downloadTemplateList
	| xmlDoc  |
	xmlDoc := XMLDOMParser parseDocumentFrom: url asUrl retrieveContents.
	templates := OrderedCollection new.
	xmlDoc allElementsNamed: #template do: [ :each | templates add: (self createTemplateFromXMLNode: each) ].
