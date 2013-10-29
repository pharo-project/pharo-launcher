accessing
options
	"Return a dictionary of all the options for a particular run"
	| options |
	"Because Jenkins doesn't store this information properly, we have to parse it from the url"
	options := Dictionary new.
	(self url segments atWrap: -2) splitOn: $, do: [ :option | | pair |
		pair := option splitOn: $=.
		options at: pair first put: pair second ].
	
	^ options