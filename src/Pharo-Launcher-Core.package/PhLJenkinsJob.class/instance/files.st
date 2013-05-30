accessing
files
	| artifacts build buildUrl |
	build := Json readFromString: (url / 'lastSuccessfulBuild' / 'api' / 'json') retrieveContents.
	artifacts := build at: #artifacts.
	buildUrl := (build at: #url) asZnUrl.
	^ artifacts
		inject: OrderedCollection new
		into: [ :files :artifact | | relativePath absolutePath |
			relativePath := artifact at: #relativePath.
			absolutePath := buildUrl / 'artifact' / relativePath.
			files add: absolutePath.
			files ]