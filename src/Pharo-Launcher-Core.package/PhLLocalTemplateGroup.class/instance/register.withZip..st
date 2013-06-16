private
register: aRemoteTemplate withZip: aZipFile
	"Update my cache file by adding information about a new zip file as described in aRemoteTemplate"
	| aDictionary templateDescription |
	aDictionary := self dictionary.
	templateDescription := aDictionary at: aRemoteTemplate name ifAbsentPut: [ Dictionary new ].
	self update: templateDescription with: aRemoteTemplate.
	self saveToFile: aDictionary