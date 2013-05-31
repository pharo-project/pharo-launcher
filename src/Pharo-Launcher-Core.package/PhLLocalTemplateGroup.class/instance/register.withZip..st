private
register: aRemoteTemplate withZip: aZipFile
	| aDictionary aSubDictionary |
	aDictionary := self dictionary.
	aSubDictionary := aDictionary at: aRemoteTemplate name ifAbsentPut: [ Dictionary new ].
	self update: aSubDictionary with: aRemoteTemplate.
	self saveToFile: aDictionary