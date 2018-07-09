tests-misc
testPathesMultiValuedPath
	| model selection |
	
	model := Array
		with:
			(TreeNodePresenter new
				content: #NodeB;
				parentNode: (TreeNodePresenter new content: #NodeA);
				yourself).
				
	selection := PhLTreeSelection with: model.
	
	self 
		assert: selection pathes first first
		equals: '#NodeA'.
	self 
		assert: selection pathes first second
		equals: '#NodeB'