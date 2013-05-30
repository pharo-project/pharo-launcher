registry
register: aPhLRemoteTemplate withZip: aZipFile
	| aDictionary aFileName aSubDictionary |
	aFileName := self baseDirectory / aPhLRemoteTemplate name , 'zip'.
	self flag: 'TODO a better implementation'.
	aZipFile = aFileName 
		ifFalse: [
	aZipFile moveTo: aFileName ensureDeleted] .
	aDictionary := self dictionary.
	aSubDictionary := aDictionary at: aPhLRemoteTemplate name ifAbsentPut: [ Dictionary new ].
	self update: aSubDictionary with: aPhLRemoteTemplate.
	self saveToFile:aDictionary