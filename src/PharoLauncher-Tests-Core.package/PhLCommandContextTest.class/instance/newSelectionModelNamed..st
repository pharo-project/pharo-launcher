as yet unclassified
newSelectionModelNamed: aNameString
	| aSelection aNode |
	
	aNode := PhLRemoteTemplate name: aNameString url: ''.
	aSelection := PhLTreeSelection
		with:
			{(TreeNodeModel new
				content: aNode;
				yourself)}.
				
	^ aSelection