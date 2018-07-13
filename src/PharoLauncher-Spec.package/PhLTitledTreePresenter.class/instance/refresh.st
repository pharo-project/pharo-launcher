updating
refresh
	|roots|
	roots := self repositoryRoots. 

	tree roots: (roots collect: [:root | 
		TreeNodePresenter new 
			content: root;
			isExpanded: root isHighlighted ]).
	tree selectedItems: (tree selectedItems intersection: roots)