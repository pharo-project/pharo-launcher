defaults
defaultFilterPattern
	"Returns the default filter pattern (Pharo6). The parenthesis here are important because this is what we want to extract for each match. The #subexpression must correspond to the index of this pair of parenthesis"
	^'href="([^"]*.zip)"' 