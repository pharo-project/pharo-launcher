accessing
regex
	"Cache the regex tree so that we don't recompute it all the time"
	^ Regex ifNil: [ Regex := RxParser parse: 'href="([^"]*.zip)"' ]