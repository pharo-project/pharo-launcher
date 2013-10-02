private
addGroup: aGroup
	| cache |
	cache := PhLCacheTemplateGroup group: aGroup. "wrap all groups inside a cache."
	aGroup isLocal "always put the local groups before the rest for rapid access"
		ifTrue: [ groupCaches addFirst: cache ]
		ifFalse: [ groupCaches addLast: cache ]