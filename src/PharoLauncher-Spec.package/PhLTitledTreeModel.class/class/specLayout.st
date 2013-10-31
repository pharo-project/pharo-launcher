specs
specLayout
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :col | 
					col
						newRow: [ :titlebar | 
									titlebar
										add: #title;
										add: #toolbar ]
							height: 25;
						add: #tree ];
		yourself