private - filtering
selectFirstItem
	| first |
	
	first := tree roots ifEmpty: [ ^self ] ifNotEmpty: [:items | items first ].
	"Not sure how to select first?"
	tree
		takeKeyboardFocus;
		selectAll