accessing
templatesAndGroups
	^ self artifacts
		inject: OrderedCollection new
		into: [ :templates :artifact | 
			artifact isPotentialTemplate
				ifTrue: [ templates add: artifact asTemplate ].
			templates ]