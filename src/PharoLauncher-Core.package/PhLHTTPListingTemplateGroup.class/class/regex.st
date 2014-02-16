accessing
regex
	"Cache the regex tree so that we don't recompute it all the time"
	^ Regex ifNil: [ Regex := RxParser parse: 'href="([^"]*.zip)"' "the parenthesis here are important because this is what we want to extract for each match. The #subexpression must correspond to the index of this pair of parenthesis."]