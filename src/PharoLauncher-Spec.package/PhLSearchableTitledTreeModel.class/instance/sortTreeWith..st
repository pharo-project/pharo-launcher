private - filtering
sortTreeWith: sortBlock
	"Sort the model tree with a 2 parameter sortBlock"
	| roots |
	roots := self repositoryRoots asSortedCollection: sortBlock.

	tree roots: (roots collect: [:root | 
		TreeNodeModel new 
			content: root;
			isExpanded: root isHighlighted ]).
	tree selectedItems: (tree selectedItems intersection: roots)
	