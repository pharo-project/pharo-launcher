parsing
parseOptionsFromUrl: aZnUrl 
	| options |
	options := Dictionary new.
	(aZnUrl segments atWrap: -2) splitOn: $, do: [ :option | | pair |
		pair := option splitOn: $=.
		options at: pair first put: pair second ].
	
	^ options