initialize-release
setGroups: aCollection
	| names |
	names := Set new.
	groupCaches := OrderedCollection new.
	aCollection
		do: [ :group | 
			(names includes: group name)
				ifTrue: [ PhLError signal: '2 groups must not have the same name' ]
				ifFalse: [ self addGroup: group ] ]