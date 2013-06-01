private
addGroup: aGroup
	| cache |
	cache := PhLCacheTemplateGroup group: aGroup.
	(aGroup = PhLLocalTemplateGroup default)
		ifTrue: [ templateGroups addFirst: cache ]
		ifFalse: [ templateGroups addLast: cache ]