as yet unclassified
layout
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :col | 
					col
						add: #titlebar height: 25;
						add: #tree ];
		yourself