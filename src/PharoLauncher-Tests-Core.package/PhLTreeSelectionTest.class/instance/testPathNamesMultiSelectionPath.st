tests-misc
testPathNamesMultiSelectionPath
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
	
	self assert: selection pathNames last equals: '#NodeA2-#NodeB2'