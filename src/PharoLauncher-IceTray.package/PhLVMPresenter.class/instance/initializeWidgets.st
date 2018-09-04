initialization
initializeWidgets
	| lastUpdateColumn |
	
	self initializeToolbar.
	
	vmTable := self newSmartFastTable.
	vmTable widget
		add: #name width: 50.
	lastUpdateColumn := vmTable widget 
		add: #'Last update' 
		display: [ :vm |
			| timestamp |
			timestamp := vm lastUpdateTime. 
			timestamp asDate yyyymmdd, ' ', timestamp asTime print24 
			].
	lastUpdateColumn width: 120.
	vmTable widget
		add: #'Download URL' accessing: #downloadUrl;
		intercellSpacing: 1;
		beMultipleSelection.
		
	self refresh.
	vmTable widget selectFirstVisibleRow.