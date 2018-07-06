specs
specLayout
	"Need to specify a row layout to account for the toolbar which wants to nest another one inside"

	<spec: #default>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: [ :col | col add: #labelModel ];
				newColumn: [ :col | col add: #toolbar ] width: 90];
		yourself