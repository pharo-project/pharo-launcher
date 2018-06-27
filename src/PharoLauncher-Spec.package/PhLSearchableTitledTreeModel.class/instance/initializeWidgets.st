initialization
initializeWidgets
	| detailsColumn imageColumn |
	super initializeWidgets.
	(detailsColumn := TreeColumnModel new)
		headerLabel: 'Last Modified';
		headerAction: [ self sortContentByDateModfied ];
		displayBlock: [ :item | item content file modificationTime ].
	imageColumn := tree columns first.
	imageColumn
		headerLabel: 'Name';
		headerAction: [ self sortContentByName ];
		initialWidth: 350.
		
	tree columns: (tree columns copyWith: detailsColumn).
	
	tree
		bindKeyCombination: Character cr asKeyCombination
		toAction: [ self doubleClick ].
	self searchField
		bindKeyCombination: Character tab asKeyCombination
		toAction: [ self selectFirstItem ]