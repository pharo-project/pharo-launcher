accessing
allConcreteCommands
	^ (self allSubclasses reject: #isAbstract) 
		sort: [ :c1 :c2 | 
			(c1 group = c2 group)
				ifTrue: [ c1 positionInGroup < c2 positionInGroup ]
				ifFalse: [ c1 group < c2 group ] ]