initialize-release
setName: aName url: anUrl filterPattern: aPatternString
	name := aName.
	url := anUrl.
	self class regexCache at: aName asSymbol put: (RxParser parse: aPatternString)