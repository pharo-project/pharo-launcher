adding
addTabs: associations

	associations do: [:each |
		self tab 
			addTab: (Text fromString: each key) 
			withAction: [ 	self setMorph: each value ].
		container submorphs isEmpty ifTrue: [ container addMorph: each value ]]