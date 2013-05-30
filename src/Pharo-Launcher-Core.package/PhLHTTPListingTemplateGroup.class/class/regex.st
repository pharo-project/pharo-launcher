accessing
regex
	^ Regex ifNil: [ Regex := RxParser parse: 'href="([^"]*.zip)"' ]