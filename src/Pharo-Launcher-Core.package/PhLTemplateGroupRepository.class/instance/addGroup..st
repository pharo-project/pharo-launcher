private
addGroup: aGroup
	| cache |
	cache := PhLCacheTemplateGroup group: aGroup. "wrap all groups inside a cache."
	(aGroup = PhLLocalTemplateGroup default) "always put the local group before the rest for rapid access"
		ifTrue: [ groupCaches addFirst: cache ]
		ifFalse: [ groupCaches addLast: cache ]