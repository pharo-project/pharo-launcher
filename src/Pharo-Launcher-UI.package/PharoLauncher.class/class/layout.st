accessing
layout
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :c | 
					c
						newRow: [ :r | 
							r
								add: #imagesModel right: 0.66;
								addSplitter;
								add: #templatesModel left: 0.34 ].
					c add: #statusbarModel height: 25 ];
		yourself