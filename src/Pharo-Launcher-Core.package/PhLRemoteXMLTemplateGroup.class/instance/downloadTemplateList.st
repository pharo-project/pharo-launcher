remote action
downloadTemplateList
	| xmlDoc templates |
	xmlDoc := self parseRemoteXml: url.
	templates := OrderedCollection new.
	xmlDoc allElementsNamed: self rootNodeName do: [ :each | templates add: (self createTemplateFromXMLNode: each) ].
	^ templates