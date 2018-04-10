accessing
regexCache
	"Cache the regex per version so that we don't recompute it all the time"
	^ RegexCache ifNil: [ RegexCache := Dictionary new ]