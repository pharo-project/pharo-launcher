updating
refresh
	tree roots: (self repository roots collect: [:root | TreeNodeModel new content: root; isExpanded: root isHighlighted ]).
	tree selectedItems: (tree selectedItems intersection: self repository roots)