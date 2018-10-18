"
A PhLTreeSelectionTest is a test class for testing the behavior of PhLTreeSelection
"
Class {
	#name : #PhLTreeSelectionTest,
	#superclass : #TestCase,
	#category : 'PharoLauncher-Tests-SpecUI'
}

{ #category : #'tests-misc' }
PhLTreeSelectionTest >> testPathNamesMultiSelectionPath [
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
]

{ #category : #'tests-misc' }
PhLTreeSelectionTest >> testPathNamesMultiValuedPath [
	| model selection |
	
	model := Array
		with:
			(TreeNodePresenter new
				content: #NodeB;
				parentNode: (TreeNodePresenter new content: #NodeA);
				yourself).
				
	selection := PhLTreeSelection with: model.
	
	self assert: selection pathNames first equals: '#NodeA-#NodeB'
]

{ #category : #'tests-misc' }
PhLTreeSelectionTest >> testPathNamesSingleValuePath [
	| model  selection |
	
	model := Array
		with:
			(TreeNodePresenter new
				content: #NodeA;
				yourself).
	
	selection := PhLTreeSelection with: model.
	
	self assert: selection pathNames first equals: '#NodeA'
]

{ #category : #'tests-misc' }
PhLTreeSelectionTest >> testPathesMultiSelectionPath [
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

	self 
		assert: selection pathes last first
		equals: '#NodeA2'.
	self 
		assert: selection pathes last second
		equals: '#NodeB2'
]

{ #category : #'tests-misc' }
PhLTreeSelectionTest >> testPathesMultiValuedPath [
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
]

{ #category : #'tests-misc' }
PhLTreeSelectionTest >> testPathesSingleValuePath [
	| model  selection |
	
	model := Array
		with:
			(TreeNodePresenter new
				content: #NodeA;
				yourself).
	
	selection := PhLTreeSelection with: model.
	
	self 
		assert: selection pathes first first
		equals: '#NodeA'
]
