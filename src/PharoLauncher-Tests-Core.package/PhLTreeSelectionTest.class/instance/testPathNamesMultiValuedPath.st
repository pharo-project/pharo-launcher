tests-misc
testPathNamesMultiValuedPath
	| model selection |
	
	model := Array
		with:
			(TreeNodeModel new
				content: #NodeB;
				parentNode: (TreeNodeModel new content: #NodeA);
				yourself).
				
	selection := PhLTreeSelection with: model.
	
	self assert: selection pathNames first equals: '#NodeA-#NodeB'