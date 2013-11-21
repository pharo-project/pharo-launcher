private
addGroup: aGroup
	| cache |
	cache := PhLCacheTemplateGroup group: aGroup. "wrap all groups inside a cache."
	aGroup isFast "always put the fast groups before the rest for rapid access"
		ifTrue: [ groupCaches addFirst: cache ]
		ifFalse: [ groupCaches addLast: cache ]