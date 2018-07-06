updating
refresh
	|roots|
	roots := self repositoryRoots. 

	tree roots: (roots collect: [:root | 
		TreeNodeModel new 
			content: root;
			isExpanded: root isHighlighted ]).
	tree selectedItems: (tree selectedItems intersection: roots)