private
addGroup: aGroup
	"Always put the local groups before the rest for rapid access"
	aGroup isLocal 
		ifTrue: 
		[ 	groupCaches addFirst: (PhLCacheLocalTemplateGroup group: aGroup) 
		]
		ifFalse: 
		[ 	groupCaches addLast: (PhLCacheTemplateGroup group: aGroup) 
		]