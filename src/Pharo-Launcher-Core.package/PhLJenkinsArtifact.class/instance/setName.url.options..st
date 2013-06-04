initialize-release
setName: aString url: anUrl options: aDictionary
	Halt if: [ aString isNil ].
	name := aString.
	url := anUrl.
	options := aDictionary