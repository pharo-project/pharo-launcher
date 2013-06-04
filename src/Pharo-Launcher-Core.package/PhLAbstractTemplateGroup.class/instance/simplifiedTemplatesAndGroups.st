accessing
simplifiedTemplatesAndGroups
	"Return the same thing as #templatesAndGroups, but remove empty groups and avoid nesting singleton groups"
	^ self templatesAndGroups
		inject: OrderedCollection new
		into: [ :collection :templateOrGroup | 
			templateOrGroup isGroup
				ifFalse: [ collection add: templateOrGroup ]
				ifTrue: [ 
					| innerTempsAndGroups |
					innerTempsAndGroups := templateOrGroup simplifiedTemplatesAndGroups.
					innerTempsAndGroups size > 1
						ifTrue: [ collection add: templateOrGroup ].
					innerTempsAndGroups size = 1
						ifTrue: [ collection add: innerTempsAndGroups first ]].
					collection ]