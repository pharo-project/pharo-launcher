initialization
initializeWidgets
	title := self newLabel
		text: '';
		yourself.
	tree := self newTree.
	toolbar := self newCommandToolbar.
	tree whenSelectedItemsChanged: [ self context ifNotNil: [ self updateContext ] ]