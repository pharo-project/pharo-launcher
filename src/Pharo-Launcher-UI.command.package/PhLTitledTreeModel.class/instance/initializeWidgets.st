initialization
initializeWidgets
	title := self newLabel
		text: '';
		yourself.
	tree := self newTree
		menu: [ :menu :shifted | self buildMenu: menu shifted: shifted  ].
	toolbar := self newCommandToolbar.
	tree whenSelectedItemsChanged: [ self context ifNotNil: [ self updateContext ] ]