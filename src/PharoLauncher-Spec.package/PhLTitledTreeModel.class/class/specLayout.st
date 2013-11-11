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
							height: self toolbarHeight;
						add: #tree ];
		yourself