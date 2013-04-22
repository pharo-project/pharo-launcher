items creation
fetchOnlineImage: anURL
	| xmlDoc name url tdictionary |
	xmlDoc := XMLDOMParser parseDocumentFrom: (anURL asUrl retrieveContents).
	name := OrderedCollection new.
	url := OrderedCollection new.
	tdictionary := Dictionary new.

	xmlDoc allElementsNamed: #name do: [ :each | name add: (each nodes first name) ] .
	xmlDoc allElementsNamed: #url do: [ :each | url add: (each nodes first name) ] .
	name do: [ :each | 
		self pharoVersions do: [ :element |
			Transcript cr;show: element asString, ' - ', each asString.
			((each findString: element) = 1)
			ifTrue: [ tdictionary at: each put: (url at:(name find: each))asString, 'lastSuccessfulBuild/artifact/', each asString, '.zip']].
			
			 ].
	^tdictionary
	