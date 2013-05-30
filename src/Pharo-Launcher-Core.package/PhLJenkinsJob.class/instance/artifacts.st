accessing
artifacts
	| artifacts json |
	json := Json readFromString: (url / 'lastSuccessfulBuild' / 'api' / 'json') retrieveContents.
	artifacts := json at: #artifacts.
	^ artifacts
		inject: OrderedCollection new
		into: [ :images :artifact | |file|
			file := artifact at: #relativePath.
			(file asFileReference extension = 'zip')
				ifTrue: [images add: (PhLRemoteTemplate
														name: name
														url: (json at: #url) asZnUrl / file
														categories: nil)]]