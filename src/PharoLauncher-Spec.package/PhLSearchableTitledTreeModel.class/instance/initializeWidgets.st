initialization
initializeWidgets
	| detailsColumn imageColumn timestampColumn |
	
	super initializeWidgets.
	
	(timestampColumn := TreeColumnModel new) 
		headerLabel: 'Last Modified';
		headerAction: [ self sortContentByDateModfied ];
		displayBlock: [ :item | 
			| timestamp |
			timestamp := item content file modificationTime.
			timestamp asDate yyyymmdd, ' ', timestamp asTime print24 ];
		initialWidth: 250.
		
	(detailsColumn := TreeColumnModel new) 
		headerLabel: 'Template';
		headerAction: [ self sortContentByTemplate ];
		displayBlock: [ :item | item content originTemplateName ].
		
	imageColumn := tree columns first.
	imageColumn 
		headerLabel: 'Name';
		headerAction: [ self sortContentByName ];
		initialWidth: 350.

	tree columns: (tree columns, { timestampColumn. detailsColumn }).