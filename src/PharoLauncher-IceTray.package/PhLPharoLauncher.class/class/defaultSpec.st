specs
defaultSpec
	<spec: #default>

	^ SpecLayout composed
		newColumn: [ :column | 
			column add: #imagesTable.
			column addSplitter.
			column add: #propertyPanel ];
		yourself.
		