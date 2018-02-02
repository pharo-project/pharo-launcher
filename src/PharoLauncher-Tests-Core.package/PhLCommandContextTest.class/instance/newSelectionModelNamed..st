utility
newSelectionModelNamed: aNameString
	| aSelection aNode |
	
	aNode := PhLRemoteTemplate name: aNameString url: ''.
	aSelection := PhLTreeSelection
		with:
			{(TreeNodeModel new
				content: aNode;
				parentNode: (TreeNodeModel new content: #parent);
				yourself)}.
				
	^ aSelection