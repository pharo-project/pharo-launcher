registry
register: aPhLRemoteTemplate
	| aDictionary |
	aDictionary := dictionary at: aPhLRemoteTemplate name ifAbsentPut: [ Dictionary new ].
	self update: aDictionary with: aPhLRemoteTemplate.