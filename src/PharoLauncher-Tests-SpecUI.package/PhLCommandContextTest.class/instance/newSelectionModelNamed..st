utility
newSelectionModelNamed: aNameString
	| aSelection aNode |
	
	aNode := PhLRemoteTemplate name: aNameString url: ''.
	aSelection := PhLTreeSelection
		with:
			{(TreeNodePresenter new
				content: aNode;
				parentNode: (TreeNodePresenter new content: #parent);
				yourself)}.
				
	^ aSelection