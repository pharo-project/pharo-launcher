tests-misc
testPathNamesMultiSelectionPath
	| model  selection |
	
	model := Array
		with:
			(TreeNodePresenter new
				content: #NodeB1;
				parentNode: (TreeNodePresenter new content: #NodeA1);
				yourself)
		with:
			(TreeNodePresenter new
				content: #NodeB2;
				parentNode: (TreeNodePresenter new content: #NodeA2);
				yourself).
					
	selection := PhLTreeSelection with: model.
	
	self assert: selection pathNames last equals: '#NodeA2-#NodeB2'