initialization
initializeWidgets
	| detailsColumn imageColumn archColumn timestampColumn |
	
	super initializeWidgets.
	
	(timestampColumn := TreeColumnPresenter new) 
		headerLabel: 'Last Modified';
		headerAction: [ self sortContentByDateModfied ];
		displayBlock: [ :item | self printDateOfLastModificationOf: item ];
		initialWidth: 250.
		
	(archColumn := TreeColumnPresenter new) 
		headerLabel: 'Arch';
		headerAction: [ self sortContentByArch ];
		displayBlock: [ :item | item content arch ].
		
	(detailsColumn := TreeColumnPresenter new) 
		headerLabel: 'Template';
		headerAction: [ self sortContentByTemplate ];
		displayBlock: [ :item | item content originTemplateName ].
		
	imageColumn := tree columns first.
	imageColumn 
		headerLabel: 'Name';
		headerAction: [ self sortContentByName ];
		initialWidth: 350.

	tree columns: (tree columns, { timestampColumn . detailsColumn . archColumn}).
	
	tree
		bindKeyCombination: Character cr asKeyCombination
		toAction: [ self doubleClick ].
	self searchField
		bindKeyCombination: Character tab asKeyCombination
		toAction: [ self selectFirstItem ]