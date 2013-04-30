as yet unclassified
fetchOnlineImage: aFileName

	| xmlDoc list |	
	xmlDoc := XMLDOMParser parseFileNamed: aFileName.
	list := OrderedCollection new.
	xmlDoc allElementsNamed: #template do: [:each | 
			list add: (PharoLauncherElement
				name: (each nodes elementAt: #name) nodes first string 
				url: (each nodes elementAt: #url) nodes first string  
				category: (each nodes elementAt: #category) nodes first string )].
	^ list 