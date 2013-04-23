items creation
fetchOnlineImage: anURL
	| xmlDoc name url tdictionary |
	xmlDoc := XMLDOMParser parseDocumentFrom: (anURL asUrl retrieveContents).
	name := OrderedCollection new.
	url := OrderedCollection new.
	tdictionary := Dictionary new.

	xmlDoc allElementsNamed: #name do: [ :each | name add: (each nodes first name) ] .
	xmlDoc allElementsNamed: #url do: [ :each | url add: (each nodes first name) ] .
	name with: url do: [ :eachName :eachUrl | 
		self pharoVersions do: [ :element |
			Transcript cr;show: element asString, ' - ', eachName asString.
			(eachName beginsWith: element)
			ifTrue: [ tdictionary at: eachName put: eachUrl asString, 'lastSuccessfulBuild/artifact/', eachName asString, '.zip']].
			
			 ].
	^tdictionary
	