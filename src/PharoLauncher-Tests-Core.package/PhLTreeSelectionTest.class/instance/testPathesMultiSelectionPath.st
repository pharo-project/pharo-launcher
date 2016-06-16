tests-misc
testPathesMultiSelectionPath
	| model  selection |
	
	model := Array
		with:
			(TreeNodeModel new
				content: #NodeB1;
				parentNode: (TreeNodeModel new content: #NodeA1);
				yourself)
		with:
			(TreeNodeModel new
				content: #NodeB2;
				parentNode: (TreeNodeModel new content: #NodeA2);
				yourself).
					
	selection := PhLTreeSelection with: model.
	

	self 
		assert: selection pathes last first
		equals: '#NodeA2'.
	self 
		assert: selection pathes last second
		equals: '#NodeB2'