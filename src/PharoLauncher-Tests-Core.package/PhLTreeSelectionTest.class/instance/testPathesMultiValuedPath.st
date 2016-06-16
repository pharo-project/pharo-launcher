tests-misc
testPathesMultiValuedPath
	| model selection |
	
	model := Array
		with:
			(TreeNodeModel new
				content: #NodeB;
				parentNode: (TreeNodeModel new content: #NodeA);
				yourself).
				
	selection := PhLTreeSelection with: model.
	
	self 
		assert: selection pathes first first
		equals: '#NodeA'.
	self 
		assert: selection pathes first second
		equals: '#NodeB'