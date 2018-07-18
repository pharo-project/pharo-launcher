tests-misc
testPathNamesSingleValuePath
	| model  selection |
	
	model := Array
		with:
			(TreeNodePresenter new
				content: #NodeA;
				yourself).
	
	selection := PhLTreeSelection with: model.
	
	self assert: selection pathNames first equals: '#NodeA'