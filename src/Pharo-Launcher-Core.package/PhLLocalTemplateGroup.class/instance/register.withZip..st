registry
register: aPhLRemoteTemplate withZip: aZipFile
	| aDictionary aFileName |
	aFileName := self baseDirectory / aPhLRemoteTemplate name , 'zip'.
	aZipFile moveTo: aFileName ensureDeleted .
	aDictionary := dictionary at: aPhLRemoteTemplate name ifAbsentPut: [ Dictionary new ].
	self update: aDictionary with: aPhLRemoteTemplate