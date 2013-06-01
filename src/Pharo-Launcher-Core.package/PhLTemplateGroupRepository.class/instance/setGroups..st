initialize-release
setGroups: aCollection
	| names |
	names := Set new.
	templateGroups := OrderedCollection new.
	aCollection
		do: [ :group | 
			(names includes: group name)
				ifTrue: [ Error signal: '2 groups must not have the same name' ]
				ifFalse: [ self addGroup: group ] ]