tests-misc
testPathNamesMultiValuedPath
	| model selection |
	
	model := Array
		with:
			(TreeNodePresenter new
				content: #NodeB;
				parentNode: (TreeNodePresenter new content: #NodeA);
				yourself).
				
	selection := PhLTreeSelection with: model.
	
	self assert: selection pathNames first equals: '#NodeA-#NodeB'