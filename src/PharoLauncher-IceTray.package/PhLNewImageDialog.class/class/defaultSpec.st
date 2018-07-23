specs
defaultSpec
	<spec: #default>

	^ SpecLayout composed
		newColumn: [ :column | 
			column add: #catalogTable.
			column addSplitter.
"			column add: #propertyPanel" ];
		yourself.
		