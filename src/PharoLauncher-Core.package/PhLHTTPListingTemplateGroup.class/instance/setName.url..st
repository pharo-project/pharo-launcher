initialize-release
setName: aName url: anUrl
	name := aName.
	url := anUrl.
	self class regexCache at: aName asSymbol put: (RxParser parse: self class defaultFilterPattern) 